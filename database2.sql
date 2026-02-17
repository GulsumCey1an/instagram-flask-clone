--
-- PostgreSQL database dump
--

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2025-12-13 12:52:31

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16813)
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    text character varying(2200) NOT NULL,
    comment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16812)
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO postgres;

--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 223
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- TOC entry 225 (class 1259 OID 16837)
-- Name: likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.likes (
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    like_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.likes OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16917)
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer CONSTRAINT message_id_not_null NOT NULL,
    sender_id integer CONSTRAINT message_sender_id_not_null NOT NULL,
    receiver_id integer CONSTRAINT message_receiver_id_not_null NOT NULL,
    text character varying(1000) CONSTRAINT message_text_not_null NOT NULL,
    media_url character varying(255),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT message_created_date_not_null NOT NULL
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16916)
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.message_id_seq OWNER TO postgres;

--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 230
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.message_id_seq OWNED BY public.messages.id;


--
-- TOC entry 233 (class 1259 OID 17690)
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    notification_id integer CONSTRAINT notification_notification_id_not_null NOT NULL,
    user_id integer CONSTRAINT notification_user_id_not_null NOT NULL,
    from_user_id integer CONSTRAINT notification_from_user_id_not_null NOT NULL,
    post_id integer,
    comment_id integer,
    message_id integer,
    notification_type character varying(10),
    message character varying(255),
    is_read boolean DEFAULT false CONSTRAINT notification_is_read_not_null NOT NULL,
    notification_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT notification_notification_date_not_null NOT NULL,
    CONSTRAINT notification_notification_type_check CHECK (((notification_type)::text = ANY ((ARRAY['request'::character varying, 'message'::character varying, 'tag'::character varying, 'like'::character varying, 'comment'::character varying])::text[])))
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17689)
-- Name: notification_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_notification_id_seq OWNER TO postgres;

--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 232
-- Name: notification_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_notification_id_seq OWNED BY public.notifications.notification_id;


--
-- TOC entry 222 (class 1259 OID 16790)
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    post_id integer NOT NULL,
    user_id integer NOT NULL,
    media_url character varying(255),
    caption character varying(2200),
    tagged_user_id integer,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16789)
-- Name: posts_post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.posts_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_post_id_seq OWNER TO postgres;

--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 221
-- Name: posts_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.posts_post_id_seq OWNED BY public.posts.post_id;


--
-- TOC entry 226 (class 1259 OID 16856)
-- Name: savedposts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.savedposts (
    user_id integer CONSTRAINT savedpost_user_id_not_null NOT NULL,
    post_id integer CONSTRAINT savedpost_post_id_not_null NOT NULL,
    saved_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT savedpost_saved_date_not_null NOT NULL
);


ALTER TABLE public.savedposts OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16899)
-- Name: stories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stories (
    id integer NOT NULL,
    user_id integer NOT NULL,
    media_url character varying(255) NOT NULL,
    viewing_info integer,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expire_date timestamp without time zone NOT NULL
);


ALTER TABLE public.stories OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16898)
-- Name: stories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stories_id_seq OWNER TO postgres;

--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 228
-- Name: stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stories_id_seq OWNED BY public.stories.id;


--
-- TOC entry 227 (class 1259 OID 16875)
-- Name: userrelations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userrelations (
    follower_id integer NOT NULL,
    following_id integer NOT NULL,
    relation_type character varying(10) NOT NULL,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT userrelations_relation_type_check CHECK (((relation_type)::text = ANY ((ARRAY['follow'::character varying, 'block'::character varying, 'requested'::character varying])::text[])))
);


ALTER TABLE public.userrelations OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16771)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(30) NOT NULL,
    email character varying(50) NOT NULL,
    full_name character varying(30),
    password character varying(255) NOT NULL,
    phone character(11),
    profile_photo character varying(255),
    biography character varying(150),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16770)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4897 (class 2604 OID 16816)
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- TOC entry 4905 (class 2604 OID 16920)
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.message_id_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 17693)
-- Name: notifications notification_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notification_notification_id_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 16793)
-- Name: posts post_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts ALTER COLUMN post_id SET DEFAULT nextval('public.posts_post_id_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 16902)
-- Name: stories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stories ALTER COLUMN id SET DEFAULT nextval('public.stories_id_seq'::regclass);


--
-- TOC entry 4893 (class 2604 OID 16774)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 5104 (class 0 OID 16813)
-- Dependencies: 224
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, user_id, post_id, text, comment_date) FROM stdin;
1	3	1	I wish you success, it looks exciting!	2025-12-02 23:25:48.030328
2	4	2	The use of light is excellent, congratulations!	2025-12-02 23:25:48.030328
3	1	3	What a magnificent view! Which hotel did you stay at?	2025-12-03 23:25:48.030328
4	2	4	Adding it to my list immediately, thank you!	2025-12-03 23:25:48.030328
5	16	4	Would you recommend this book to me too? 😊	2025-12-07 20:25:48.030328
6	6	5	Very good motivation!	2025-12-04 23:25:48.030328
7	7	1	Which language are you using for this project?	2025-12-04 23:25:48.030328
8	5	7	Happy holidays! Just what I needed.	2025-12-05 23:25:48.030328
9	10	8	I love your voice, keep going!	2025-12-05 23:25:48.030328
10	9	9	The graphics were really impressive.	2025-12-06 23:25:48.030328
11	8	3	It’s a beautiful spot for a break, I love it!	2025-12-03 23:25:48.030328
12	23	1	The conference notes are very valuable, thank you Tayfun!	2025-12-07 13:25:48.030328
13	1	23	Should we integrate this into the internal company project?	2025-12-07 21:25:48.030328
14	1	9	Emre, I found a new bug in this game, should I send it to you?	2025-12-07 20:25:48.030328
15	11	15	The recipe looks great, I’m going to try it too. Well done Caner!	2025-12-07 22:55:48.030328
16	17	14	Your workspace is very inspiring Irem.	2025-12-07 17:25:48.030328
17	7	31	The stream was very fun, great job!	2025-12-07 21:25:48.030328
18	20	21	A moment full of peace. Namaste. 🙏	2025-12-07 18:25:48.030328
19	18	20	It’s like I can smell the natural soaps from here!	2025-12-07 15:25:48.030328
20	11	24	Where did you get the Pad Thai? It looks authentic!	2025-12-07 22:25:48.030328
21	16	4	If we look at it from a philosophical perspective...	2025-12-06 23:25:48.030328
22	7	6	We must listen to this cover live soon!	2025-12-07 19:25:48.030328
23	12	11	What a cute little one! What is its name?	2025-12-07 22:25:48.030328
24	10	2	Ayşe, the light in this photo is perfect!	2025-12-05 23:25:48.030328
25	9	27	The cinematography is very successful, I agree.	2025-12-06 23:25:48.030328
26	5	8	Oh my God, this view is a dream!	2025-12-04 23:25:48.030328
27	18	17	I love the passion for gardening.	2025-12-04 23:25:48.030328
28	22	19	A design suitable for the theatre stage, very experimental.	2025-12-07 18:25:48.030328
29	4	25	Vildan, these verses touched my heart.	2025-12-06 23:25:48.030328
30	1	27	A great perspective!	2025-12-07 22:25:48.030328
31	3	1	I wish you success, it looks exciting!	2025-12-02 23:26:45.974856
32	4	2	The use of light is excellent, congratulations!	2025-12-02 23:26:45.974856
33	1	3	What a magnificent view! Which hotel did you stay at?	2025-12-03 23:26:45.974856
34	2	4	Adding it to my list immediately, thank you!	2025-12-03 23:26:45.974856
35	16	4	Would you recommend this book to me too? 😊	2025-12-07 20:26:45.974856
36	6	5	Very good motivation!	2025-12-04 23:26:45.974856
37	7	1	Which language are you using for this project?	2025-12-04 23:26:45.974856
38	5	7	Happy holidays! Just what I needed.	2025-12-05 23:26:45.974856
39	10	8	I love your voice, keep going!	2025-12-05 23:26:45.974856
40	9	9	The graphics were really impressive.	2025-12-06 23:26:45.974856
41	8	3	It’s a beautiful spot for a break, I love it!	2025-12-03 23:26:45.974856
42	23	1	The conference notes are very valuable, thank you Tayfun!	2025-12-07 13:26:45.974856
43	1	23	Should we integrate this into the internal company project?	2025-12-07 21:26:45.974856
44	1	9	Emre, I found a new bug in this game, should I send it to you?	2025-12-07 20:26:45.974856
45	11	15	The recipe looks great, I’m going to try it too. Well done Caner!	2025-12-07 22:56:45.974856
46	17	14	Your workspace is very inspiring Irem.	2025-12-07 17:26:45.974856
47	7	31	The stream was very fun, great job!	2025-12-07 21:26:45.974856
48	20	21	A moment full of peace. Namaste. 🙏	2025-12-07 18:26:45.974856
49	18	20	It’s like I can smell the natural soaps from here!	2025-12-07 15:26:45.974856
50	11	24	Where did you get the Pad Thai? It looks authentic!	2025-12-07 22:26:45.974856
51	16	4	If we look at it from a philosophical perspective...	2025-12-06 23:26:45.974856
52	7	6	We must listen to this cover live soon!	2025-12-07 19:26:45.974856
53	12	11	What a cute little one! What is its name?	2025-12-07 22:26:45.974856
54	10	2	Ayşe, the light in this photo is perfect!	2025-12-05 23:26:45.974856
55	9	27	The cinematography is very successful, I agree.	2025-12-06 23:26:45.974856
56	5	8	Oh my God, this view is a dream!	2025-12-04 23:26:45.974856
57	18	17	I love the passion for gardening.	2025-12-04 23:26:45.974856
58	22	19	A design suitable for the theatre stage, very experimental.	2025-12-07 18:26:45.974856
59	4	25	Vildan, these verses touched my heart.	2025-12-06 23:26:45.974856
60	1	27	A great perspective!	2025-12-07 22:26:45.974856
\.


--
-- TOC entry 5105 (class 0 OID 16837)
-- Dependencies: 225
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.likes (user_id, post_id, like_date) FROM stdin;
1	2	2025-12-03 23:55:04.26991
1	4	2025-12-04 23:55:04.26991
1	5	2025-12-05 23:55:04.26991
1	7	2025-12-05 23:55:04.26991
2	1	2025-12-02 23:55:04.26991
2	3	2025-12-03 23:55:04.26991
2	5	2025-12-04 23:55:04.26991
3	2	2025-12-02 23:55:04.26991
3	4	2025-12-03 23:55:04.26991
3	6	2025-12-04 23:55:04.26991
4	1	2025-12-02 23:55:04.26991
5	1	2025-12-03 23:55:04.26991
6	1	2025-12-04 23:55:04.26991
7	9	2025-12-05 23:55:04.26991
8	9	2025-12-06 23:55:04.26991
10	9	2025-12-06 23:55:04.26991
11	23	2025-12-07 13:55:04.26991
12	23	2025-12-07 14:55:04.26991
13	23	2025-12-07 15:55:04.26991
14	17	2025-12-07 16:55:04.26991
15	36	2025-12-07 17:55:04.26991
16	11	2025-12-07 18:55:04.26991
17	13	2025-12-07 19:55:04.26991
18	27	2025-12-07 20:55:04.26991
20	31	2025-12-07 22:55:04.26991
21	32	2025-12-07 23:25:04.26991
22	22	2025-12-07 23:40:04.26991
14	1	2025-12-06 23:55:04.26991
15	3	2025-12-06 23:55:04.26991
16	23	2025-12-06 23:55:04.26991
17	9	2025-12-06 23:55:04.26991
18	1	2025-12-06 23:55:04.26991
19	3	2025-12-06 23:55:04.26991
20	23	2025-12-06 23:55:04.26991
21	9	2025-12-06 23:55:04.26991
22	1	2025-12-06 23:55:04.26991
23	3	2025-12-06 23:55:04.26991
24	23	2025-12-06 23:55:04.26991
25	9	2025-12-06 23:55:04.26991
26	1	2025-12-06 23:55:04.26991
27	3	2025-12-06 23:55:04.26991
28	23	2025-12-06 23:55:04.26991
29	9	2025-12-06 23:55:04.26991
30	1	2025-12-06 23:55:04.26991
1	3	2025-12-06 23:55:04.26991
4	8	2025-12-06 23:55:04.26991
5	14	2025-12-06 23:55:04.26991
6	15	2025-12-06 23:55:04.26991
7	37	2025-12-06 23:55:04.26991
\.


--
-- TOC entry 5111 (class 0 OID 16917)
-- Dependencies: 231
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, sender_id, receiver_id, text, media_url, created_date) FROM stdin;
1	1	2	Hi Ayşe, how are you?	\N	2025-12-08 00:08:24.241057
2	2	1	I'm good Ahmet, thank you. You?	\N	2025-12-08 00:08:24.241057
3	1	2	Shall we grab coffee this weekend?	\N	2025-12-08 00:08:24.241057
4	2	1	That would be great, where should we meet?	\N	2025-12-08 00:08:24.241057
5	1	2	I was thinking of that newly opened book cafe. I'll send you a photo.	http://media.com/kitap_kafe.jpg	2025-12-08 00:08:24.241057
6	2	1	I love it! Perfect, is 3 o'clock okay?	\N	2025-12-08 00:08:24.241057
7	5	6	How's your new gym?	\N	2025-12-08 00:08:24.241057
8	6	5	I'm very satisfied, it's very clean.	http://media.com/gym_photo.jpg	2025-12-08 00:08:24.241057
9	5	6	I'm thinking of dropping by the gym sometime.	\N	2025-12-08 00:08:24.241057
10	6	5	You definitely should come! This is a photo of the new machine set.	http://media.com/new_gym_equipment.jpg	2025-12-08 00:08:24.241057
11	5	6	Wow, it looks very good!	\N	2025-12-08 00:08:24.241057
12	7	8	What's the trick to this game?	https://www.instagram.com/stories/guler_emre/138283980013284676/	2025-12-08 00:08:24.241057
13	8	7	I sent you a DM, let's talk there.	\N	2025-12-08 00:08:24.241057
14	7	8	Okay, thanks.	\N	2025-12-08 00:08:24.241057
15	9	10	I really liked your movie review.	\N	2025-12-08 00:08:24.241057
16	10	9	Thank you, do you have a recommendation for the next movie?	\N	2025-12-08 00:08:24.241057
17	9	10	I recommend you watch The Mentalist, especially this scene impressed me a lot.	http://youtube.com/watch?v=BEMFdscl	2025-12-08 00:08:24.241057
18	10	9	I had watched this before, the scene that impressed me was not this one.	http://youtube.com/watch?v=NTYfrCsgl	2025-12-08 00:08:24.241057
19	9	10	Maybe this scene will interest you more.	http://youtube.com/watch?v=AnotherScene	2025-12-08 00:08:24.241057
20	3	4	There's a place like this, what do you think?	http://starbucks.com/starb_photo.jpg	2025-12-08 00:08:24.241057
21	4	3	I have a better place idea, how about this one?	http://colombia.com/caffe_photo.jpg	2025-12-08 00:08:24.241057
22	3	4	What should I wear when going there? Do you think this is suitable?	http://media.com/galery_photo.jpg	2025-12-08 00:08:24.241057
23	4	3	That would be great, I'm thinking of wearing this style	http://media.com/galery_photo.jpg	2025-12-08 00:08:24.241057
24	3	4	Super, I'm wearing that outfit then! See you.	\N	2025-12-08 00:08:24.241057
25	11	12	You should have come to this activism event too!	\N	2025-12-08 00:08:24.241057
26	12	11	Ah, I wish I could have come, next time.	http://media.com/aktivizm_event.png	2025-12-08 00:08:24.241057
27	11	12	Absolutely! We can take this photo at the next meeting.	http://media.com/new_aktivizm_plan.jpg	2025-12-08 00:08:24.241057
28	13	18	Which fertilizer do you use for the tomatoes in the garden?	\N	2025-12-08 00:08:24.241057
29	18	13	I use organic liquid fertilizer, I'm sending a photo.	http://media.com/gubre_markasi.jpg	2025-12-08 00:08:24.241057
30	13	18	Thank you very much! Do you have any seed brand recommendations?	\N	2025-12-08 00:08:24.241057
31	23	1	What do you think about the new cyber attack?	\N	2025-12-08 00:08:24.241057
32	1	23	I'm reading the article right away, can you send me the link?	\N	2025-12-08 00:08:24.241057
33	23	1	Here you go, article link: https://techblog.com/siber_atak	\N	2025-12-08 00:08:24.241057
34	27	9	Shall we watch this movie together?	\N	2025-12-08 00:08:24.241057
35	9	27	Great idea, I'll buy the tickets!	\N	2025-12-08 00:08:24.241057
36	27	9	Which session did you get? This is a photo of the hall.	http://media.com/sinema_salon_foto.jpg	2025-12-08 00:08:24.241057
\.


--
-- TOC entry 5113 (class 0 OID 17690)
-- Dependencies: 233
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (notification_id, user_id, from_user_id, post_id, comment_id, message_id, notification_type, message, is_read, notification_date) FROM stdin;
93	1	7	9	\N	\N	tag	guler_emre tagged you in a post.	t	2025-12-07 21:23:50.847592
94	8	3	12	\N	\N	tag	m.kaya tagged you in a post.	f	2025-12-08 00:23:50.847592
95	7	6	14	\N	\N	tag	dnzcan tagged you in a post.	f	2025-12-07 23:23:50.847592
96	12	11	15	\N	\N	tag	caner_arslan tagged you in a post.	t	2025-12-06 00:23:50.847592
97	9	17	17	\N	\N	tag	murat_tekin tagged you in a post.	f	2025-12-08 00:23:50.847592
98	22	20	20	\N	\N	tag	pelin_aksu tagged you in a post.	t	2025-12-08 00:18:50.847592
99	1	23	23	\N	\N	tag	tayfun_erdem tagged you in a post.	f	2025-12-07 00:23:50.847592
100	4	25	25	\N	\N	tag	vildan_simsek tagged you in a post.	f	2025-12-08 00:23:50.847592
101	9	27	26	\N	\N	tag	zuhal_kaya tagged you in a post.	t	2025-12-07 18:23:50.847592
102	5	8	32	\N	\N	tag	fatmaclk tagged you in a post.	f	2025-12-08 00:23:50.847592
103	18	13	35	\N	\N	tag	hakan_taner tagged you in a post.	t	2025-12-07 14:23:50.847592
104	17	14	36	\N	\N	tag	irem.kilic tagged you in a post.	f	2025-12-08 00:23:50.847592
105	1	3	1	1	\N	comment	m.kaya commented on your post.	t	2025-12-03 00:23:50.847592
106	2	4	2	2	\N	comment	zeynep02 commented on your post.	f	2025-12-03 00:23:50.847592
107	3	1	3	3	\N	comment	ahmet_ylz commented on your post.	t	2025-12-04 00:23:50.847592
108	4	2	4	4	\N	comment	aydemir commented on your post.	f	2025-12-04 00:23:50.847592
109	4	16	4	5	\N	comment	leyla_ozer commented on your post.	t	2025-12-07 21:23:50.847592
110	5	6	5	6	\N	comment	dnzcan commented on your post.	t	2025-12-05 00:23:50.847592
111	1	7	1	7	\N	comment	guler_emre commented on your post.	f	2025-12-05 00:23:50.847592
112	7	5	7	8	\N	comment	ali_y commented on your post.	f	2025-12-06 00:23:50.847592
113	8	10	8	9	\N	comment	gizay.u commented on your post.	t	2025-12-06 00:23:50.847592
114	7	9	9	10	\N	comment	burak01 commented on your post.	f	2025-12-07 00:23:50.847592
115	3	8	3	11	\N	comment	fatmaclk commented on your post.	t	2025-12-04 00:23:50.847592
116	1	23	1	12	\N	comment	tayfun_erdem commented on your post.	f	2025-12-07 14:23:50.847592
117	23	1	23	13	\N	comment	ahmet_ylz commented on your post.	t	2025-12-07 22:23:50.847592
118	7	1	9	14	\N	comment	ahmet_ylz commented on your post.	f	2025-12-07 21:23:50.847592
119	11	11	15	15	\N	comment	caner_arslan commented on their own post.	t	2025-12-07 23:53:50.847592
120	6	17	14	16	\N	comment	murat_tekin commented on your post.	f	2025-12-07 18:23:50.847592
121	7	7	31	17	\N	comment	guler_emre commented on their own post.	t	2025-12-07 22:23:50.847592
122	20	20	21	18	\N	comment	pelin_aksu commented on their own post.	f	2025-12-07 19:23:50.847592
123	18	18	20	19	\N	comment	nesrin_sahin commented on their own post.	t	2025-12-07 16:23:50.847592
124	24	11	24	20	\N	comment	caner_arslan commented on your post.	f	2025-12-07 23:23:50.847592
125	4	16	4	21	\N	comment	leyla_ozer commented on your post.	f	2025-12-07 00:23:50.847592
126	6	7	6	22	\N	comment	guler_emre commented on your post.	t	2025-12-07 20:23:50.847592
127	11	12	11	23	\N	comment	elif_soylu commented on your post.	f	2025-12-07 23:23:50.847592
128	2	10	2	24	\N	comment	gizay.u commented on your post.	t	2025-12-06 00:23:50.847592
129	27	9	27	25	\N	comment	burak01 commented on your post.	f	2025-12-07 00:23:50.847592
130	8	5	8	26	\N	comment	ali_y commented on your post.	t	2025-12-05 00:23:50.847592
131	17	18	17	27	\N	comment	nesrin_sahin commented on your post.	f	2025-12-05 00:23:50.847592
132	19	22	19	28	\N	comment	sevgi_akdag commented on your post.	t	2025-12-07 19:23:50.847592
133	25	4	25	29	\N	comment	zeynep02 commented on your post.	f	2025-12-07 00:23:50.847592
134	27	1	27	30	\N	comment	ahmet_ylz commented on your post.	t	2025-12-07 23:23:50.847592
135	2	1	2	\N	\N	like	ahmet_ylz liked your post.	f	2025-12-04 00:23:50.847592
136	4	1	4	\N	\N	like	ahmet_ylz liked your post.	t	2025-12-05 00:23:50.847592
137	5	1	5	\N	\N	like	ahmet_ylz liked your post.	f	2025-12-06 00:23:50.847592
138	7	1	7	\N	\N	like	ahmet_ylz liked your post.	t	2025-12-06 00:23:50.847592
139	1	2	1	\N	\N	like	aydemir liked your post.	f	2025-12-03 00:23:50.847592
140	3	2	3	\N	\N	like	aydemir liked your post.	t	2025-12-04 00:23:50.847592
141	5	2	5	\N	\N	like	aydemir liked your post.	f	2025-12-05 00:23:50.847592
142	2	3	2	\N	\N	like	m.kaya liked your post.	t	2025-12-03 00:23:50.847592
143	4	3	4	\N	\N	like	m.kaya liked your post.	f	2025-12-04 00:23:50.847592
144	1	3	6	\N	\N	like	m.kaya liked your post.	t	2025-12-05 00:23:50.847592
145	1	4	1	\N	\N	like	zeynep02 liked your post.	f	2025-12-03 00:23:50.847592
146	1	5	1	\N	\N	like	ali_y liked your post.	t	2025-12-04 00:23:50.847592
147	1	6	1	\N	\N	like	dnzcan liked your post.	f	2025-12-05 00:23:50.847592
148	7	7	9	\N	\N	like	guler_emre liked their own post.	t	2025-12-06 00:23:50.847592
149	7	8	9	\N	\N	like	fatmaclk liked your post.	f	2025-12-07 00:23:50.847592
150	7	10	9	\N	\N	like	gizay.u liked your post.	t	2025-12-07 00:23:50.847592
151	23	11	23	\N	\N	like	caner_arslan liked your post.	f	2025-12-07 14:23:50.847592
152	23	12	23	\N	\N	like	elif_soylu liked your post.	t	2025-12-07 15:23:50.847592
153	23	13	23	\N	\N	like	hakan_taner liked your post.	f	2025-12-07 16:23:50.847592
154	17	14	17	\N	\N	like	irem.kilic liked your post.	t	2025-12-07 17:23:50.847592
155	14	15	36	\N	\N	like	kaan_simsek liked your post.	f	2025-12-07 18:23:50.847592
156	11	16	11	\N	\N	like	leyla_ozer liked your post.	t	2025-12-07 19:23:50.847592
157	4	17	13	\N	\N	like	murat_tekin liked your post.	f	2025-12-07 20:23:50.847592
158	1	18	27	\N	\N	like	nesrin_sahin liked your post.	t	2025-12-07 21:23:50.847592
159	3	19	3	\N	\N	like	ozturk_yigit liked your post.	f	2025-12-07 22:23:50.847592
160	7	20	31	\N	\N	like	pelin_aksu liked your post.	t	2025-12-07 23:23:50.847592
161	8	21	32	\N	\N	like	ridvan_uysal liked your post.	f	2025-12-07 23:53:50.847592
162	22	22	22	\N	\N	like	sevgi_akdag liked their own post.	t	2025-12-08 00:08:50.847592
163	1	14	1	\N	\N	like	irem.kilic liked your post.	f	2025-12-07 00:23:50.847592
164	3	15	3	\N	\N	like	kaan_simsek liked your post.	t	2025-12-07 00:23:50.847592
165	23	16	23	\N	\N	like	leyla_ozer liked your post.	f	2025-12-07 00:23:50.847592
166	7	17	9	\N	\N	like	murat_tekin liked your post.	t	2025-12-07 00:23:50.847592
167	1	18	1	\N	\N	like	nesrin_sahin liked your post.	f	2025-12-07 00:23:50.847592
168	3	19	3	\N	\N	like	ozturk_yigit liked your post.	t	2025-12-07 00:23:50.847592
169	23	20	23	\N	\N	like	pelin_aksu liked your post.	f	2025-12-07 00:23:50.847592
170	7	21	9	\N	\N	like	ridvan_uysal liked your post.	t	2025-12-07 00:23:50.847592
171	1	22	1	\N	\N	like	sevgi_akdag liked your post.	f	2025-12-07 00:23:50.847592
172	3	23	3	\N	\N	like	tayfun_erdem liked your post.	t	2025-12-07 00:23:50.847592
173	23	24	23	\N	\N	like	ufuk_guler liked your post.	f	2025-12-07 00:23:50.847592
174	7	25	9	\N	\N	like	vildan_simsek liked your post.	t	2025-12-07 00:23:50.847592
175	1	26	1	\N	\N	like	yasin_ozer liked your post.	f	2025-12-07 00:23:50.847592
176	3	27	3	\N	\N	like	zuhal_kaya liked your post.	t	2025-12-07 00:23:50.847592
177	23	28	23	\N	\N	like	hakki_dogu liked your post.	f	2025-12-07 00:23:50.847592
178	7	29	9	\N	\N	like	deniz_sari liked your post.	t	2025-12-07 00:23:50.847592
179	1	30	1	\N	\N	like	melisa_koc liked your post.	f	2025-12-07 00:23:50.847592
180	3	1	3	\N	\N	like	ahmet_ylz liked your post.	t	2025-12-07 00:23:50.847592
181	8	4	8	\N	\N	like	zeynep02 liked your post.	f	2025-12-07 00:23:50.847592
182	14	5	14	\N	\N	like	ali_y liked your post.	t	2025-12-07 00:23:50.847592
183	15	6	15	\N	\N	like	dnzcan liked your post.	f	2025-12-07 00:23:50.847592
184	17	7	37	\N	\N	like	guler_emre liked your post.	t	2025-12-07 00:23:50.847592
221	12	13	\N	\N	\N	request	hakan_taner wants to follow you.	f	2025-12-07 20:23:50.847592
222	12	16	\N	\N	\N	request	leyla_ozer wants to follow you.	t	2025-12-07 21:23:50.847592
223	18	19	\N	\N	\N	request	ozturk_yigit wants to follow you.	f	2025-12-07 22:23:50.847592
224	18	20	\N	\N	\N	request	pelin_aksu wants to follow you.	f	2025-12-07 23:23:50.847592
225	25	21	\N	\N	\N	request	ridvan_uysal wants to follow you.	t	2025-12-07 23:53:50.847592
226	21	25	\N	\N	\N	request	vildan_simsek wants to follow you.	f	2025-12-07 23:55:50.847592
227	22	26	\N	\N	\N	request	yasin_ozer wants to follow you.	t	2025-12-07 23:58:50.847592
228	26	22	\N	\N	\N	request	sevgi_akdag wants to follow you.	f	2025-12-08 00:03:50.847592
229	13	29	\N	\N	\N	request	deniz_sari wants to follow you.	t	2025-12-08 00:08:50.847592
230	29	13	\N	\N	\N	request	hakan_taner wants to follow you.	f	2025-12-08 00:13:50.847592
231	24	30	\N	\N	\N	request	melisa_koc wants to follow you.	f	2025-12-08 00:18:50.847592
232	30	24	\N	\N	\N	request	ufuk_guler wants to follow you.	t	2025-12-08 00:21:50.847592
233	2	1	\N	\N	1	message	ahmet_ylz sent you a new message.	f	2025-12-08 13:13:36.751136
234	1	2	\N	\N	2	message	aydemir sent you a new message.	t	2025-12-08 13:14:36.751136
235	2	1	\N	\N	3	message	ahmet_ylz sent you a new message.	f	2025-12-08 13:15:36.751136
236	1	2	\N	\N	4	message	aydemir sent you a new message.	f	2025-12-08 13:16:36.751136
237	2	1	\N	\N	5	message	ahmet_ylz sent you a new message.	t	2025-12-08 13:17:36.751136
238	1	2	\N	\N	6	message	aydemir sent you a new message.	f	2025-12-08 13:18:36.751136
239	6	5	\N	\N	7	message	ali_y sent you a new message.	t	2025-12-08 13:19:36.751136
240	5	6	\N	\N	8	message	dnzcan sent you a new message.	f	2025-12-08 13:20:36.751136
241	6	5	\N	\N	9	message	ali_y sent you a new message.	t	2025-12-08 13:21:36.751136
242	5	6	\N	\N	10	message	dnzcan sent you a new message.	f	2025-12-08 13:22:36.751136
243	6	5	\N	\N	11	message	ali_y sent you a new message.	t	2025-12-08 13:23:36.751136
244	8	7	\N	\N	12	message	guler_emre sent you a new message.	f	2025-12-08 13:24:06.751136
245	7	8	\N	\N	13	message	fatmaclk sent you a new message.	t	2025-12-08 13:24:16.751136
246	8	7	\N	\N	14	message	guler_emre sent you a new message.	f	2025-12-08 13:24:26.751136
247	10	9	\N	\N	15	message	burak01 sent you a new message.	t	2025-12-08 13:24:36.751136
248	9	10	\N	\N	16	message	gizay.u sent you a new message.	f	2025-12-08 13:24:51.751136
249	10	9	\N	\N	17	message	burak01 sent you a new message.	f	2025-12-08 13:25:06.751136
250	9	10	\N	\N	18	message	gizay.u sent you a new message.	t	2025-12-08 13:25:21.751136
251	10	9	\N	\N	19	message	burak01 sent you a new message.	f	2025-12-08 13:25:36.751136
252	4	3	\N	\N	20	message	m.kaya sent you a new message.	t	2025-12-08 13:25:51.751136
253	3	4	\N	\N	21	message	zeynep02 sent you a new message.	f	2025-12-08 13:26:06.751136
254	4	3	\N	\N	22	message	m.kaya sent you a new message.	t	2025-12-08 13:26:21.751136
255	3	4	\N	\N	23	message	zeynep02 sent you a new message.	f	2025-12-08 13:26:36.751136
256	4	3	\N	\N	24	message	m.kaya sent you a new message.	t	2025-12-08 13:26:51.751136
257	12	11	\N	\N	25	message	caner_arslan sent you a new message.	f	2025-12-08 13:27:06.751136
258	11	12	\N	\N	26	message	elif_soylu sent you a new message.	t	2025-12-08 13:27:21.751136
259	12	11	\N	\N	27	message	caner_arslan sent you a new message.	f	2025-12-08 13:27:36.751136
260	18	13	\N	\N	28	message	hakan_taner sent you a new message.	t	2025-12-08 13:27:51.751136
261	13	18	\N	\N	29	message	nesrin_sahin sent you a new message.	f	2025-12-08 13:27:56.751136
262	18	13	\N	\N	30	message	hakan_taner sent you a new message.	t	2025-12-08 13:28:01.751136
263	1	23	\N	\N	31	message	tayfun_erdem sent you a new message.	f	2025-12-08 13:28:06.751136
264	23	1	\N	\N	32	message	ahmet_ylz sent you a new message.	t	2025-12-08 13:28:11.751136
265	1	23	\N	\N	33	message	tayfun_erdem sent you a new message.	f	2025-12-08 13:28:16.751136
266	9	27	\N	\N	34	message	zuhal_kaya sent you a new message.	t	2025-12-08 13:28:21.751136
267	27	9	\N	\N	35	message	burak01 sent you a new message.	f	2025-12-08 13:28:26.751136
268	9	27	\N	\N	36	message	zuhal_kaya sent you a new message.	f	2025-12-08 13:28:31.751136
\.


--
-- TOC entry 5102 (class 0 OID 16790)
-- Dependencies: 222
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (post_id, user_id, media_url, caption, tagged_user_id, created_date) FROM stdin;
1	1	https://www.instagram.com/p/DjDzg/	First steps of my new software project!	\N	2025-12-07 23:20:35.350835
2	2	https://www.instagram.com/p/AXbYcZdIeF2/	A frame I shot in Rome.	10	2025-12-07 23:20:35.350835
3	3	https://www.instagram.com/p/G7hK41Mzw3/	Cappadocia balloons are amazing!	\N	2025-12-07 23:20:35.350835
4	4	https://www.instagram.com/p/K6lPbcDE/	The best book I read this month.	16	2025-12-07 23:20:35.350835
5	5	https://www.instagram.com/p/PQrKsYjZ/	New record attempt! 	28	2025-12-07 23:20:35.350835
6	1	https://www.instagram.com/p/GVxKqjKM/	Favorite coding tip of the week: DRV.	\N	2025-12-07 23:20:35.350835
7	3	https://www.instagram.com/p/RJvbIpHyIZ/	Sun, sand, sea..	\N	2025-12-07 23:20:35.350835
8	6	https://www.instagram.com/p/Zg9XyBjN1i/	A cover of my favorite song.	7	2025-12-07 23:20:35.350835
9	7	https://www.instagram.com/p/HmWKLYT/	Have you tried the new game?	1	2025-12-07 23:20:35.350835
10	8	https://www.instagram.com/p/SItBrx0/	The view from the summit is breathtaking.	\N	2025-12-07 23:20:35.350835
11	1	https://www.instagram.com/p/Ahmet_Tech/	My new mechanical keyboard.	23	2025-12-07 23:20:35.350835
12	3	https://www.instagram.com/p/MKY_Travel/	A place far away. Peace...	8	2025-12-07 23:20:35.350835
13	4	https://www.instagram.com/p/Zeynep_Coffee/	A new third-wave coffee shop I discovered.	18	2025-12-07 23:20:35.350835
14	6	https://www.instagram.com/p/Deniz_Music/	A short clip from a live performance.	7	2025-12-07 23:20:35.350835
15	11	https://www.instagram.com/p/CanerFood/	Butter chicken I made this weekend. Recipe soon!	12	2025-12-07 23:20:35.350835
16	12	https://www.instagram.com/p/Elif_Activist/	A shot from today’s protest. Let’s make our voices heard!	\N	2025-12-07 23:20:35.350835
17	13	https://www.instagram.com/p/Hakan_Garden/	Fresh tomatoes from the garden. The reward for my effort.	18	2025-12-07 23:20:35.350835
18	14	https://www.instagram.com/p/Irem_Design/	New logo design. With a minimalist approach.	24	2025-12-07 23:20:35.350835
19	17	https://www.instagram.com/p/Murat_Car/	The final look of my new modification project.	9	2025-12-07 23:20:35.350835
20	18	https://www.instagram.com/p/Nesrin_Bio/	Handmade natural soaps I made.	22	2025-12-07 23:20:35.350835
21	20	https://www.instagram.com/p/Pelin_Yoga/	Morning yoga brings peace. 	22	2025-12-07 23:20:35.350835
22	22	https://www.instagram.com/p/Sevgi_Ceramic/	One of my new ceramics.	13	2025-12-07 23:20:35.350835
23	23	https://www.instagram.com/p/Tayfun_Cyber/	Notes from the cybersecurity conference.	1	2025-12-07 23:20:35.350835
24	24	https://www.instagram.com/p/Ufuk_Food/	I tried Thai-style Pad Thai today. 	11	2025-12-07 23:20:35.350835
25	25	https://www.instagram.com/p/Vildan_Poetry/	My new poetry attempt. Waiting for your comments.	4	2025-12-07 23:20:35.350835
26	27	https://www.instagram.com/p/Zuhal_Film/	The last movie I watched really impressed me. I recommend it.	9	2025-12-07 23:20:35.350835
27	1	https://www.instagram.com/p/Ahmet_Code/	Trying out a new algorithm.	23	2025-12-07 23:20:35.350835
28	3	https://www.instagram.com/p/MK_Hiking/	Discovering new routes.	8	2025-12-07 23:20:35.350835
29	4	https://www.instagram.com/p/Zeynep_Book/	Coffee and a good book.	16	2025-12-07 23:20:35.350835
30	6	https://www.instagram.com/p/Deniz_Cover/	An acoustic cover.	7	2025-12-07 23:20:35.350835
31	7	https://www.instagram.com/p/Emre_Stream/	Live stream has started!	6	2025-12-07 23:20:35.350835
32	8	https://www.instagram.com/p/Fatma_Hike/	A challenging climb.	5	2025-12-07 23:20:35.350835
33	11	https://www.instagram.com/p/Caner_Recipe/	My favorite dessert recipe.	\N	2025-12-07 23:20:35.350835
34	12	https://www.instagram.com/p/Elif_Cat/	My new cat.	12	2025-12-07 23:20:35.350835
35	13	https://www.instagram.com/p/Hakan_Tool/	My new gardening tool.	18	2025-12-07 23:20:35.350835
36	14	https://www.instagram.com/p/Irem_Office/	Today’s workspace.	17	2025-12-07 23:20:35.350835
37	17	https://www.instagram.com/p/Murat_Engine/	Listen to the engine sound!	9	2025-12-07 23:20:35.350835
\.


--
-- TOC entry 5106 (class 0 OID 16856)
-- Dependencies: 226
-- Data for Name: savedposts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.savedposts (user_id, post_id, saved_date) FROM stdin;
1	4	2025-12-02 23:58:49.511543
1	8	2025-12-03 23:58:49.511543
2	1	2025-12-03 23:58:49.511543
3	5	2025-12-04 23:58:49.511543
4	9	2025-12-05 23:58:49.511543
5	3	2025-12-05 23:58:49.511543
6	7	2025-12-06 23:58:49.511543
7	23	2025-12-06 23:58:49.511543
8	17	2025-12-06 23:58:49.511543
9	13	2025-12-07 13:58:49.511543
10	1	2025-12-07 15:58:49.511543
11	9	2025-12-07 17:58:49.511543
12	3	2025-12-07 19:58:49.511543
13	23	2025-12-07 20:58:49.511543
14	1	2025-12-07 22:58:49.511543
\.


--
-- TOC entry 5109 (class 0 OID 16899)
-- Dependencies: 229
-- Data for Name: stories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stories (id, user_id, media_url, viewing_info, created_date, expire_date) FROM stdin;
1	1	https://www.instagram.com/stories/ahmet_ylz/3780744980013284676/	18500	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
2	1	https://www.instagram.com/stories/ahmet_ylz/1283992232133284676/	15100	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
3	7	https://www.instagram.com/stories/guler_emre/3293812398483990033839/	13900	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
4	4	https://www.instagram.com/stories/zeynep02/93929839298390230983/	12550	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
5	1	https://www.instagram.com/stories/ahmet_ylz/3382981020012984676/	14050	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
6	10	https://www.instagram.com/stories/gizay.u/2317762371723612323676/	16800	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
7	7	https://www.instagram.com/stories/guler_emre/384320387132319131/	15750	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
8	7	https://www.instagram.com/stories/guler_emre/1382839800132846/	14600	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
9	8	https://www.instagram.com/stories/fatmaclk/291939219839231923990/	11400	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
10	10	https://www.instagram.com/stories/gizay.u/112838199421232312334/	17720	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
11	12	https://www.instagram.com/stories/elif_s/3452319800132846/	8850	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
12	12	https://www.instagram.com/stories/elif_s/9123880013284676/	7790	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
13	12	https://www.instagram.com/stories/elif_s/1029384500132846/	9910	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
14	14	https://www.instagram.com/stories/irem_k/3947812300132846/	6100	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
15	14	https://www.instagram.com/stories/irem_k/1234710013284676/	5050	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
16	17	https://www.instagram.com/stories/murat_t/9021380013284676/	3550	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
17	18	https://www.instagram.com/stories/nesrin_s/87654320013284676/	3600	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
18	20	https://www.instagram.com/stories/pelin_a/14567890013284676/	4720	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
19	22	https://www.instagram.com/stories/sevgi_a/112233440013284676/	2480	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
20	27	https://www.instagram.com/stories/zuhal_k/98765430013284676/	2350	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
21	2	https://www.instagram.com/stories/aydemir/56789010013284676/	1210	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
22	11	https://www.instagram.com/stories/caner_a/10293840013284676/	980	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
23	13	https://www.instagram.com/stories/hakan_t/77777770013284676/	490	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
24	24	https://www.instagram.com/stories/ufuk_g/88888880013284676/	620	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
25	25	https://www.instagram.com/stories/vildan_s/99999990013284676/	505	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
26	27	https://www.instagram.com/stories/zuhal_k/135792460013284676/	800	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
27	1	https://www.instagram.com/stories/ahmet_ylz/41123450013284676/	15250	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
28	7	https://www.instagram.com/stories/guler_emre/45567890013284676/	14950	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
29	8	https://www.instagram.com/stories/fatmaclk/41098760013284676/	11350	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
30	10	https://www.instagram.com/stories/gizay.u/40011220013284676/	16650	2025-12-08 00:04:58.705983	2025-12-09 00:04:58.705983
\.


--
-- TOC entry 5107 (class 0 OID 16875)
-- Dependencies: 227
-- Data for Name: userrelations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userrelations (follower_id, following_id, relation_type, created_date, updated_date) FROM stdin;
2	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
3	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
4	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
17	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
19	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
20	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
21	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
22	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
23	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
29	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
5	7	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
6	7	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
11	7	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
12	7	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
23	7	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
24	7	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
25	7	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
26	7	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
27	7	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
9	10	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
11	10	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
28	10	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
29	10	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
30	10	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
12	14	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
15	17	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
17	18	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
18	17	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
22	24	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
1	4	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
7	4	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
1	3	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
1	2	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
7	5	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
7	6	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
10	9	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
10	11	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
14	12	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
17	15	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
4	9	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
9	4	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
8	2	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
1	7	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
7	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
30	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
8	7	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
5	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
5	10	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
14	8	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
1	5	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
10	5	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
1	30	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
10	30	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
2	27	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
3	27	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
4	7	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
24	22	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
2	8	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
8	14	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
27	2	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
12	1	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
25	17	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
28	22	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
16	21	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
21	16	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
28	29	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
29	28	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
2	29	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
3	29	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
10	28	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
14	20	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
15	22	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
16	20	follow	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
13	12	requested	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
16	12	requested	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
19	18	requested	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
20	18	requested	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
21	25	requested	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
25	21	requested	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
26	22	requested	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
22	26	requested	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
29	13	requested	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
13	29	requested	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
30	24	requested	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
24	30	requested	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
1	25	block	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
26	2	block	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
27	3	block	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
28	4	block	2025-12-08 00:12:09.798498	2025-12-08 00:12:09.798498
\.


--
-- TOC entry 5100 (class 0 OID 16771)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, username, email, full_name, password, phone, profile_photo, biography, created_date) FROM stdin;
1	ahmet_ylz	ahmet.yilmaz@gmail.com	Ahmet Yılmaz	TechGuru123	05551234567	https://s3.cloudstorage.com/ahmet_yilmaz/profile_pic_2024.png	Technology and software enthusiast.	2025-12-07 23:12:50.993762
2	aydemir	ayse.demir@gmail.com	Ayşe Demir	ArtLover2015	05452345678	https://s3.cloudstorage.com/aydemir/profile_pic_2015.png	Art history and photography.	2025-12-07 23:12:50.993762
3	m.kaya	mehmet.kaya@gmail.com	Mehmet Kaya	ExploreWorld	05353456789	https://s3.cloudstorage.com/m.kaya/profile_pic_2025.png	Traveler, loves discovering new places.	2025-12-07 23:12:50.993762
4	zeynep02	zeynep.ozturk@hotmail.c...	Zeynep Öztürk	CoffeeBook02	05454567890	https://s3.cloudstorage.com/zeynep02/profile_pic_2023.png	Bookworm and coffee addict.	2025-12-07 23:12:50.993762
5	ali_y	ali.yildirim@gmail.com	Ali Yıldırım	GoHardGym	05386789012	\N	Sports, fitness, and healthy living.	2025-12-07 23:12:50.993762
6	dnzcan	deniz.can@hotmail.com	Deniz Can	GuitarStudent	05386789012	https://s3.cloudstorage.com/dnzcan/profile_pic_2011.png	A student who loves music and playing the guitar.	2025-12-07 23:12:50.993762
7	guler_emre	emre.guler@gmail.com	Emre Güler	GamerLife	05547890123	https://s3.cloudstorage.com/guler_emre/profile_pic_2012.png	Gaming and e-sports world.	2025-12-07 23:12:50.993762
8	fatmaclk	fatma.celik@gmail.com	Fatma Çelik	HikeCamp24	05498901234	https://s3.cloudstorage.com/fatmaclk/profile_pic_2015.png	Nature walks and camping.	2025-12-07 23:12:50.993762
9	burak01	burak.aksoy@hotmail.com	Burak Aksoy	MovieCritic	05459012345	https://s3.cloudstorage.com/burak01/profile_pic_2023.png	Film critic.	2025-12-07 23:12:50.993762
10	gizay.u	gizay.uzun@gmail.com	Gizay Uzun	FashionBlogger	05450123456	\N	Fashion and beauty blogger.	2025-12-07 23:12:50.993762
11	caner_arslan	caner.arslan@gmail.com	Caner Arslan	ChefCaner	05451112233	https://s3.cloudstorage.com/caner_arslan/profile_pic_2022.png	Loves cooking and trying new cuisines, always compassionate.	2025-12-07 23:12:50.993762
12	elif_soylu	elif.soylu@gmail.com	Elif Soylu	CatMomActivist	05692223344	https://s3.cloudstorage.com/elif_soylu/profile_pic_2021.png	Animal rights activist and cat mother.	2025-12-07 23:12:50.993762
13	hakan_taner	hakan.taner@hotmail.com	Hakan Taner	RetiredGarden	05353334455	https://s3.cloudstorage.com/hakan_taner/profile_pic_2015.png	Retired teacher, a man who loves gardening.	2025-12-07 23:12:50.993762
14	irem.kilic	irem.kilic@hotmail.com	İrem Kılıç	MinimalDesign	0534445566 	https://s3.cloudstorage.com/irem_kilic/profile_pic_2021.png	Graphic designer, embracing minimalist living.	2025-12-07 23:12:50.993762
15	kaan_simsek	kaan.simsek@gmail.com	Kaan Şimşek	DronePilot	04445556677	\N	Drone pilot, aerial photography.	2025-12-07 23:12:50.993762
16	leyla_ozer	leyla.ozer@gmail.com	Leyla Özer	DeepThoughts	05456667788	\N	Philosophy student, curious about deep subjects.	2025-12-07 23:12:50.993762
17	murat_tekin	murat.tekin@hotmail.com	Murat Tekin	CarModLover	05327778899	https://s3.cloudstorage.com/murat_tekin/profile_pic_2015.png	Automobile enthusiast and modification expert.	2025-12-07 23:12:50.993762
18	nesrin_sahin	nesrin.sahin@gmail.com	Nesrin Şahin	HealthyLife	05658889900	https://s3.cloudstorage.com/nesrin_sahin/profile_pic_2015.png	Natural cosmetics and healthy eating.	2025-12-07 23:12:50.993762
19	ozturk_yigit	ozturk.yigit@gmail.com	Öztürk Yiğit	StageActor	05699990011	\N	Amateur actor, stage arts.	2025-12-07 23:12:50.993762
20	pelin_aksu	pelin.aksu@gmail.com	Pelin Aksu	YogaPeace	05320001122	https://s3.cloudstorage.com/pelin_aksu/profile_pic_2015.png	Yoga and meditation instructor.	2025-12-07 23:12:50.993762
21	ridvan_uysal	ridvan.uysal@gmail.com	Rıdvan Uysal	ArchaeologyFan	05459213456	\N	Interested in historical buildings and archaeology.	2025-12-07 23:12:50.993762
22	sevgi_akdag	sevgi.akdag@gmail.com	Sevgi Akdağ	CeramicArtist	05351324567	https://s3.cloudstorage.com/sevgi_akdag/profile_pic_2018.png	Handicrafts, especially a ceramic artist.	2025-12-07 23:12:50.993762
23	tayfun_erdem	tayfun.erdem@gmail.com	Tayfun Erdem	CyberSecure	05243435678	https://s3.cloudstorage.com/tayfun_erdem/profile_pic_2022.png	Software security specialist and cybersecurity consultant.	2025-12-07 23:12:50.993762
24	ufuk_guler	ufuk.guler@hotmail.com	Ufuk Güler	AsianFoodie	05243546789	https://s3.cloudstorage.com/ufuk_guler/profile_pic_2011.png	Southeast Asian cuisine fan.	2025-12-07 23:12:50.993762
25	vildan_simsek	vildan.simsek@gmail.com	Vildan Şimşek	PoetCritic	05554657890	https://s3.cloudstorage.com/vildan_simsek/profile_pic_2015.png	Literary critic and poet.	2025-12-07 23:12:50.993762
26	yasin_ozer	yasin.ozer@gmail.com	Yasin Özer	NewIdeaBiz	0555768901 	\N	Entrepreneur, chasing new business ideas.	2025-12-07 23:12:50.993762
27	zuhal_kaya	zuhal.kaya@gmail.com	Zuhal Kaya	FilmFestival	0555679812 	https://s3.cloudstorage.com/zuhal_kaya/profile_pic_2025.png	Cinema enthusiast who follows film festivals.	2025-12-07 23:12:50.993762
28	hakki_dogu	hakki.dogu@hotmail.com	Hakkı Doğu	ChessMaster	05557980123	\N	Professional chess player.	2025-12-07 23:12:50.993762
29	deniz_sari	deniz.sari@gmail.com	Deniz Sarı	GreenPlanet	05558091234	\N	Environmental sciences and sustainability topics.	2025-12-07 23:12:50.993762
30	melisa_koc	melisa.koc@gmail.com	Melisa Koç	PhotoStyle	05559102345	https://s3.cloudstorage.com/melisa_koc/profile_pic_2020.png	Fashion photographer and style consultant.	2025-12-07 23:12:50.993762
\.


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 223
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 60, true);


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 230
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.message_id_seq', 36, true);


--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 232
-- Name: notification_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_notification_id_seq', 268, true);


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 221
-- Name: posts_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_post_id_seq', 37, true);


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 228
-- Name: stories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stories_id_seq', 30, true);


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 30, true);


--
-- TOC entry 4921 (class 2606 OID 16826)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 4923 (class 2606 OID 16845)
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (user_id, post_id);


--
-- TOC entry 4931 (class 2606 OID 16930)
-- Name: messages message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- TOC entry 4933 (class 2606 OID 17703)
-- Name: notifications notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notification_pkey PRIMARY KEY (notification_id);


--
-- TOC entry 4919 (class 2606 OID 16801)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (post_id);


--
-- TOC entry 4925 (class 2606 OID 16864)
-- Name: savedposts savedpost_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.savedposts
    ADD CONSTRAINT savedpost_pkey PRIMARY KEY (user_id, post_id);


--
-- TOC entry 4929 (class 2606 OID 16910)
-- Name: stories stories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT stories_pkey PRIMARY KEY (id);


--
-- TOC entry 4927 (class 2606 OID 16887)
-- Name: userrelations userrelations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userrelations
    ADD CONSTRAINT userrelations_pkey PRIMARY KEY (follower_id, following_id, relation_type);


--
-- TOC entry 4913 (class 2606 OID 16788)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4915 (class 2606 OID 16784)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4917 (class 2606 OID 16786)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4942 (class 2606 OID 16888)
-- Name: userrelations fk_follower; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userrelations
    ADD CONSTRAINT fk_follower FOREIGN KEY (follower_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4943 (class 2606 OID 16893)
-- Name: userrelations fk_following; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userrelations
    ADD CONSTRAINT fk_following FOREIGN KEY (following_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4947 (class 2606 OID 17719)
-- Name: notifications fk_notification_comments; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notification_comments FOREIGN KEY (comment_id) REFERENCES public.comments(id) ON DELETE CASCADE;


--
-- TOC entry 4948 (class 2606 OID 17709)
-- Name: notifications fk_notification_from_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notification_from_user FOREIGN KEY (from_user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4949 (class 2606 OID 17724)
-- Name: notifications fk_notification_message; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notification_message FOREIGN KEY (message_id) REFERENCES public.messages(id) ON DELETE CASCADE;


--
-- TOC entry 4950 (class 2606 OID 17714)
-- Name: notifications fk_notification_post; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notification_post FOREIGN KEY (post_id) REFERENCES public.posts(post_id) ON DELETE CASCADE;


--
-- TOC entry 4951 (class 2606 OID 17704)
-- Name: notifications fk_notification_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_notification_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4936 (class 2606 OID 16832)
-- Name: comments fk_post; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_post FOREIGN KEY (post_id) REFERENCES public.posts(post_id) ON DELETE CASCADE;


--
-- TOC entry 4938 (class 2606 OID 16851)
-- Name: likes fk_post; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT fk_post FOREIGN KEY (post_id) REFERENCES public.posts(post_id) ON DELETE CASCADE;


--
-- TOC entry 4940 (class 2606 OID 16870)
-- Name: savedposts fk_post; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.savedposts
    ADD CONSTRAINT fk_post FOREIGN KEY (post_id) REFERENCES public.posts(post_id) ON DELETE CASCADE;


--
-- TOC entry 4945 (class 2606 OID 16936)
-- Name: messages fk_receiver; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_receiver FOREIGN KEY (receiver_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4946 (class 2606 OID 16931)
-- Name: messages fk_sender; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_sender FOREIGN KEY (sender_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4934 (class 2606 OID 16807)
-- Name: posts fk_tagged_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT fk_tagged_user FOREIGN KEY (tagged_user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- TOC entry 4937 (class 2606 OID 16827)
-- Name: comments fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4939 (class 2606 OID 16846)
-- Name: likes fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4935 (class 2606 OID 16802)
-- Name: posts fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4941 (class 2606 OID 16865)
-- Name: savedposts fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.savedposts
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4944 (class 2606 OID 16911)
-- Name: stories fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


-- Completed on 2025-12-13 12:52:31

--
-- PostgreSQL database dump complete
--

