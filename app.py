from flask import Flask, render_template, request, redirect, url_for
import psycopg2

app = Flask(__name__)
CURRENT_USER_ID = 1  # demo kullanıcı

# -----------------------------
# DATABASE CONNECTION
# -----------------------------
def get_db_connection():
    return psycopg2.connect(
        host="localhost",
        database="instagram",
        user="postgres",
        password="5124298.gG"
    )

# -----------------------------
# FEED
# -----------------------------
@app.route("/")
def feed():
    conn = get_db_connection()
    cur = conn.cursor()

    # =============================
    # STORIES (avatar = story media)
    # =============================
    cur.execute("""
        SELECT
            s.id,
            u.username,
            s.media_url
        FROM stories s
        JOIN users u ON s.user_id = u.user_id
        WHERE s.expire_date > NOW()
        ORDER BY s.created_date DESC
        LIMIT 10;
    """)
    story_rows = cur.fetchall()

    stories = []
    for s in story_rows:
        stories.append({
            "id": s[0],
            "username": s[1],
            "avatar": s[2],   # 🔥 story yuvarlağı
            "media": s[2]     # 🔥 popup içeriği
        })

    # =============================
    # POSTS
    # =============================
    cur.execute("""
        SELECT
            p.post_id,
            p.caption,
            p.media_url,
            u.username,
            u.profile_photo
        FROM posts p
        JOIN users u ON p.user_id = u.user_id
        ORDER BY p.post_id DESC
        LIMIT 10;
    """)
    post_rows = cur.fetchall()

    posts = []
    for p in post_rows:
        post_id = p[0]

        cur.execute("SELECT COUNT(*) FROM likes WHERE post_id = %s;", (post_id,))
        like_count = cur.fetchone()[0]

        posts.append({
            "post_id": post_id,
            "caption": p[1],
            "image_url": p[2] or "https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=900",
            "username": p[3],
            "profile_image": p[4] or "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200",
            "like_count": like_count
        })

    # =============================
    # COMMENTS
    # =============================
    cur.execute("""
        SELECT
            c.post_id,
            u.username,
            c.text
        FROM comments c
        JOIN users u ON c.user_id = u.user_id
        ORDER BY c.comment_date;
    """)
    comment_rows = cur.fetchall()

    comments = {}
    for c in comment_rows:
        comments.setdefault(c[0], []).append({
            "username": c[1],
            "text": c[2]
        })

    cur.close()
    conn.close()

    return render_template(
        "feed.html",
        stories=stories,
        posts=posts,
        comments=comments
    )
@app.route("/story/<int:story_id>")
def view_story(story_id):
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT s.media_url, u.username
        FROM stories s
        JOIN users u ON s.user_id = u.user_id
        WHERE s.id = %s AND s.expire_date > NOW();
    """, (story_id,))

    row = cur.fetchone()
    cur.close()
    conn.close()

    if not row:
        return redirect(url_for("feed"))

    return render_template("story.html", media_url=row[0], username=row[1])

# -----------------------------
# LIKE
# -----------------------------
@app.route("/like/<int:post_id>", methods=["POST"])
def like(post_id):
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO likes (user_id, post_id)
        VALUES (%s, %s)
        ON CONFLICT DO NOTHING;
    """, (CURRENT_USER_ID, post_id))

    conn.commit()
    cur.close()
    conn.close()
    return redirect(url_for("feed"))

# -----------------------------
# COMMENT
# -----------------------------
@app.route("/comment/<int:post_id>", methods=["POST"])
def comment(post_id):
    text = request.form.get("comment", "").strip()
    if not text:
        return redirect(url_for("feed"))

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO comments (user_id, post_id, text, comment_date)
        VALUES (%s, %s, %s, NOW());
    """, (CURRENT_USER_ID, post_id, text))

    conn.commit()
    cur.close()
    conn.close()
    return redirect(url_for("feed"))
# -----------------------------
# -----------------------------
# ADD POST
# -----------------------------
@app.route("/add_post", methods=["POST"])
def add_post():
    caption = request.form.get("caption")
    media_url = request.form.get("media_url")

    if not media_url:
        return redirect(url_for("profile"))

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO posts (user_id, media_url, caption)
        VALUES (%s, %s, %s);
    """, (CURRENT_USER_ID, media_url, caption))

    conn.commit()
    cur.close()
    conn.close()

    return redirect(url_for("profile"))

# -----------------------------
# DM INBOX (HER KULLANICI 1 KEZ, SON MESAJ)
# -----------------------------
@app.route("/dm")
def dm_inbox():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT DISTINCT ON (other_user_id)
            m.id,
            m.sender_id,
            m.receiver_id,
            m.text,
            m.created_date,
            u.username,
            other_user_id
        FROM (
            SELECT
                m.*,
                CASE
                    WHEN m.sender_id = %s THEN m.receiver_id
                    ELSE m.sender_id
                END AS other_user_id
            FROM messages m
            WHERE m.sender_id = %s OR m.receiver_id = %s
        ) m
        JOIN users u ON u.user_id = m.other_user_id
        ORDER BY other_user_id, m.created_date DESC;
    """, (CURRENT_USER_ID, CURRENT_USER_ID, CURRENT_USER_ID))

    rows = cur.fetchall()
    cur.close()
    conn.close()

    threads = []
    for r in rows:
        threads.append({
            "message_id": r[0],
            "other_user_id": r[6],
            "other_username": r[5],
            "text": r[3],
            "created_date": r[4]
        })

    return render_template("dm_inbox.html", threads=threads)

# -----------------------------
# DM CHAT (TEK SOHBET)
# -----------------------------
@app.route("/dm/<int:other_user_id>", methods=["GET", "POST"])
def dm_chat(other_user_id):
    conn = get_db_connection()
    cur = conn.cursor()

    # 🔹 ADIM 2.3 — POST ile gelen mesajı DB'ye yaz
    if request.method == "POST":
        message_text = request.form.get("message_text")

        if message_text:
            cur.execute("""
                INSERT INTO messages (sender_id, receiver_id, text, created_date)
                VALUES (%s, %s, %s, NOW())
            """, (CURRENT_USER_ID, other_user_id, message_text))

            conn.commit()

    # 🔹 Mesajları çek
    cur.execute("""
        SELECT
            m.sender_id,
            m.receiver_id,
            m.text,
            m.created_date,
            u.username
        FROM messages m
        JOIN users u ON u.user_id = m.sender_id
        WHERE
            (m.sender_id = %s AND m.receiver_id = %s)
            OR
            (m.sender_id = %s AND m.receiver_id = %s)
        ORDER BY m.created_date;
    """, (CURRENT_USER_ID, other_user_id, other_user_id, CURRENT_USER_ID))

    rows = cur.fetchall()
    cur.close()
    conn.close()

    messages = []
    for r in rows:
        messages.append({
            "sender_id": r[0],
            "receiver_id": r[1],
            "text": r[2],
            "created_date": r[3],
            "sender_username": r[4]
        })

    return render_template(
        "dm_chat.html",
        messages=messages,
        current_user_id=CURRENT_USER_ID,
        other_user_id=other_user_id
    )


# -----------------------------
# PROFILE (CURRENT USER)
# -----------------------------
@app.route("/profile")
def profile():
    conn = get_db_connection()
    cur = conn.cursor()

    # Kullanıcı bilgileri
    cur.execute("""
        SELECT username, full_name, biography, profile_photo
        FROM users
        WHERE user_id = %s;
    """, (CURRENT_USER_ID,))
    u = cur.fetchone()

    # Gönderi sayısı
    cur.execute("""
        SELECT COUNT(*)
        FROM posts
        WHERE user_id = %s;
    """, (CURRENT_USER_ID,))
    post_count = cur.fetchone()[0]

    # Takipçi sayısı
    cur.execute("""
        SELECT COUNT(*)
        FROM userrelations
        WHERE following_id = %s
          AND relation_type = 'follow';
    """, (CURRENT_USER_ID,))
    followers_count = cur.fetchone()[0]

    # Takip edilen sayısı
    cur.execute("""
        SELECT COUNT(*)
        FROM userrelations
        WHERE follower_id = %s
          AND relation_type = 'follow';
    """, (CURRENT_USER_ID,))
    following_count = cur.fetchone()[0]
    
    # Kullanıcının postları (profil grid için)
    cur.execute("""
        SELECT post_id, media_url
        FROM posts
        WHERE user_id = %s
        ORDER BY created_date DESC;
    """, (CURRENT_USER_ID,))
    post_rows = cur.fetchall()

    user_posts = []
    for p in post_rows:
        user_posts.append({
            "post_id": p[0],
            "media_url": p[1]
        })

    cur.close()
    conn.close()

    if not u:
        return redirect(url_for("feed"))

    return render_template(
        "profile.html",
        username=u[0],
        full_name=u[1],
        biography=u[2],
        profile_photo=u[3],
        post_count=post_count,
        followers_count=followers_count,
        following_count=following_count,
        user_posts=user_posts
    )
# -----------------------------
# FOLLOWERS LIST
# -----------------------------
@app.route("/followers")
def followers():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT u.user_id, u.username, u.profile_photo
        FROM userrelations r
        JOIN users u ON r.follower_id = u.user_id
        WHERE r.following_id = %s
          AND r.relation_type = 'follow';
    """, (CURRENT_USER_ID,))

    rows = cur.fetchall()
    cur.close()
    conn.close()

    followers = []
    for r in rows:
        followers.append({
            "user_id": r[0],
            "username": r[1],
            "profile_photo": r[2]
        })

    return render_template("followers.html", followers=followers)
# -----------------------------
# FOLLOWING LIST
# -----------------------------
@app.route("/following")
def following():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT u.user_id, u.username, u.profile_photo
        FROM userrelations r
        JOIN users u ON r.following_id = u.user_id
        WHERE r.follower_id = %s
          AND r.relation_type = 'follow';
    """, (CURRENT_USER_ID,))

    rows = cur.fetchall()
    cur.close()
    conn.close()

    following = []
    for r in rows:
        following.append({
            "user_id": r[0],
            "username": r[1],
            "profile_photo": r[2]
        })

    return render_template("following.html", following=following)

# -----------------------------
# RUN
# -----------------------------
if __name__ == "__main__":
    app.run(debug=True)
