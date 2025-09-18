<#import "layout.ftlh" as index>
<@index.layout>

    <head>
        <title>Microgram Posts</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .post-card {
                max-width: 600px;
                margin: 20px auto;
                border: 1px solid #dbdbdb;
                border-radius: 3px;
            }

            .post-header {
                padding: 10px;
                display: flex;
                align-items: center;
            }

            .post-header img {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                margin-right: 10px;
            }

            .post-image {
                width: 100%;
                height: auto;
            }

            .post-actions {
                padding: 10px;
            }

            .post-description {
                padding: 10px;
            }

            .post-stats {
                padding: 0 10px;
                color: #666;
            }

            .post-time {
                font-size: 0.8em;
                color: #999;
                padding: 0 10px 10px;
            }
        </style>
    </head>
    <div class="container">
        <div id="posts-container">
            <#list posts as post>
                <#assign avatarSrc = (post.author?? && post.author.avatar?has_content)
                ? then('/api/images/avatar/' + post.author.id, 'https://as2.ftcdn.net/v2/jpg/03/31/69/91/1000_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg') />

                <#assign imageSrc = (post.image?has_content)
                ? then('/api/images/image/' + post.id, 'https://via.placeholder.com/800x600?text=No+Image') />

                <div class="post-card">
                    <div class="post-header">
                        <img src="${avatarSrc}" alt="${post.author.username!''}">
                        <strong>${post.author.username!''}</strong>
                    </div>

                    <img src="${imageSrc}" alt="${post.description!'Post image'}" class="post-image">

                    <div class="post-actions">

                        <i class="${post.likedByMe?then('fas','far')} fa-heart"
                           data-post-id="${post.id}"
                           data-liked="${post.likedByMe?c}"
                           onclick="likePost(this)"></i>
                        <i class="far fa-comment ms-3"></i>

                    </div>

                    <div class="post-stats">
                        <strong data-like-count>${post.likesCount!0} likes</strong>
                    </div>

                    <div class="post-description">
                        <strong>${post.author.username!''}</strong> ${post.description!''}
                    </div>

                    <div class="post-stats">
                        View all ${post.commentsCount!0} comments
                    </div>

                    <div class="post-time">
                        ${post.createdAt?string("yyyy-MM-dd")}
                    </div>
                </div>
            </#list>
        </div>
    </div>

    <script>
        function likePost(elem) {
            const postId = elem.getAttribute("data-post-id");
            if (!postId) return;

            const token = document.querySelector('meta[name="_csrf"]')?.content;
            const header = document.querySelector('meta[name="_csrf_header"]')?.content || 'X-CSRF-TOKEN';

            if (elem.dataset.busy === '1') return;
            elem.dataset.busy = '1';

            const liked = elem.dataset.liked === 'true';

            fetch('/api/likes/' + postId, {
                method: liked ? 'DELETE' : 'POST',
                headers: {[header]: token}
            }).then(res => {
                if (!res.ok) {
                    if (res.status === 401) return (window.location.href = '/auth/login');
                    return alert('Ошибка при лайке');
                }

                const likeNode = elem.closest('.post-card').querySelector('[data-like-count]');
                const match = likeNode?.textContent.trim().match(/^(\d+)/);
                let count = match ? parseInt(match[1], 10) : 0;

                if (liked) {
                    elem.classList.remove('fas');
                    elem.classList.add('far');
                    elem.dataset.liked = 'false';
                    if (likeNode) likeNode.textContent = Math.max(0, count - 1) + ' likes';
                } else {
                    elem.classList.remove('far');
                    elem.classList.add('fas');
                    elem.dataset.liked = 'true';
                    if (likeNode) likeNode.textContent = (count + 1) + ' likes';
                }
            }).catch(() => {
                alert('Сеть недоступна');
            }).finally(() => {
                elem.dataset.busy = '0';
            });
        }

    </script>

</@index.layout>