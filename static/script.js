// Like button toggle functionality
document.addEventListener('DOMContentLoaded', function() {
    const likeButtons = document.querySelectorAll('.post-action-btn.like-btn');
    
    likeButtons.forEach(button => {
        button.addEventListener('click', function() {
            const postElement = this.closest('.post');
            const likesElement = postElement.querySelector('.post-likes');
            
            // Toggle liked state
            this.classList.toggle('liked');
            
            // Add animation
            this.classList.add('animate');
            setTimeout(() => {
                this.classList.remove('animate');
            }, 300);
            
            // Update likes count
            if (this.classList.contains('liked')) {
                let currentLikes = parseInt(likesElement.textContent.match(/\d+/)[0]);
                likesElement.textContent = (currentLikes + 1).toLocaleString('tr-TR') + ' beğenme';
            } else {
                let currentLikes = parseInt(likesElement.textContent.match(/\d+/)[0]);
                if (currentLikes > 0) {
                    likesElement.textContent = (currentLikes - 1).toLocaleString('tr-TR') + ' beğenme';
                }
            }
        });
    });
    
    // Comment form submission
    const commentForms = document.querySelectorAll('.post-comment-form');
    
    commentForms.forEach(form => {
        const input = form.querySelector('.post-comment-input');
        const submitBtn = form.querySelector('.post-comment-submit');
        const commentsContainer = form.closest('.post').querySelector('.post-comments');
        
        // Enable/disable submit button based on input
        input.addEventListener('input', function() {
            submitBtn.disabled = this.value.trim() === '';
        });
        
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const commentText = input.value.trim();
            if (commentText === '') return;
            
            // Create new comment element
            const commentDiv = document.createElement('div');
            commentDiv.className = 'post-comment';
            
            const usernameSpan = document.createElement('span');
            usernameSpan.className = 'post-comment-username';
            usernameSpan.textContent = 'gulsumcyln';
            
            const textSpan = document.createElement('span');
            textSpan.textContent = ' ' + commentText;
            
            commentDiv.appendChild(usernameSpan);
            commentDiv.appendChild(textSpan);
            
            // Add to comments container
            commentsContainer.appendChild(commentDiv);
            
            // Clear input
            input.value = '';
            submitBtn.disabled = true;
            
            // Scroll to new comment
            commentDiv.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        });
    });
    
    // Story click handlers
    const storyItems = document.querySelectorAll('.story-item');
    storyItems.forEach(item => {
        item.addEventListener('click', function() {
            // Story viewing functionality can be added here
            console.log('Story clicked:', this.querySelector('.story-username').textContent);
        });
    });
    
    // Smooth scroll for stories
    const storiesContainer = document.querySelector('.stories-container');
    if (storiesContainer) {
        let isDown = false;
        let startX;
        let scrollLeft;
        
        storiesContainer.addEventListener('mousedown', (e) => {
            isDown = true;
            storiesContainer.style.cursor = 'grabbing';
            startX = e.pageX - storiesContainer.offsetLeft;
            scrollLeft = storiesContainer.scrollLeft;
        });
        
        storiesContainer.addEventListener('mouseleave', () => {
            isDown = false;
            storiesContainer.style.cursor = 'grab';
        });
        
        storiesContainer.addEventListener('mouseup', () => {
            isDown = false;
            storiesContainer.style.cursor = 'grab';
        });
        
        storiesContainer.addEventListener('mousemove', (e) => {
            if (!isDown) return;
            e.preventDefault();
            const x = e.pageX - storiesContainer.offsetLeft;
            const walk = (x - startX) * 2;
            storiesContainer.scrollLeft = scrollLeft - walk;
        });
        
        storiesContainer.style.cursor = 'grab';
    }
});

