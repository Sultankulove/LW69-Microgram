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
                        <div class="post-time">${post.createdAt?string("yyyy-MM-dd")}</div>
                    </div>

                    <img src="${imageSrc}" alt="${post.description!'Post image'}" class="post-image">

                    <div class="post-actions">
                        <i class="${post.likedByMe?then('fas','far')} fa-heart"
                           data-post-id="${post.id}"
                           data-liked="${post.likedByMe?c}"
                           onclick="likePost(this)"></i>
                        <#--                        <i class="far fa-comment ms-3"></i>-->
                        <i class="far fa-comment ms-3"
                           role="button"
                           tabindex="0"
                           data-open-comments
                           data-post-id="${post.id}"
                           title="Комментарии"></i>
                    </div>

                    <#--                    <div class="post-stats">-->
                    <#--                        <button class="link-btn"-->
                    <#--                                type="button"-->
                    <#--                                data-open-comments-->
                    <#--                                data-post-id="${post.id}">-->
                    <#--                            View all ${post.commentsCount!0} comments-->
                    <#--                        </button>-->
                    <#--                    </div>-->


                    <div class="post-stats">
                        <strong data-like-count>${post.likesCount!0} likes</strong>
                    </div>

                    <div class="post-description">
                        <strong>${post.author.username!''}</strong> ${post.description!''}
                    </div>


                    <#--                    <div class="post-stats">-->
                    <#--                        View all ${post.commentsCount!0} comments-->
                    <#--                    </div>-->

                    <div class="post-stats">
                        <span class="link-btn"
                              data-open-comments
                              data-post-id="${post.id}">
                                View all ${post.commentsCount!0} comments
                        </span>
                    </div>

                    <div class="post-stats" data-comments data-post-id="${post.id}" hidden>
                        <div class="comments-list" data-comments-list></div>

                        <form class="comment-form" data-comment-form onsubmit="return false;">
                            <input type="text" name="text" maxlength="1000" placeholder="Добавьте комментарий…"/>
                            <button type="submit">Отправить</button>
                        </form>

                    <#--                    <div class="comments" data-comments data-post-id="${post.id}" hidden>-->
                    <#--                        <div class="comments-list" data-comments-list></div>-->

                    <#--                        <form class="comment-form" data-comment-form onsubmit="return false;">-->
                    <#--                            <input type="text" name="text" maxlength="1000" placeholder="Добавьте комментарий…"/>-->
                    <#--                            <button type="submit">Отправить</button>-->
                    <#--                        </form>-->
                    <#--                    </div>-->


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

        //
        document.addEventListener('click', async (e) => {
            const btn = e.target.closest('[data-open-comments]');
            if (!btn) return;
            const postId = btn.getAttribute('data-post-id');
            const box = btn.closest('.post-card').querySelector('[data-comments]');
            if (box.hasAttribute('hidden')) {
                await loadComments(postId, box.querySelector('[data-comments-list]'));
                box.removeAttribute('hidden');
            } else {
                box.setAttribute('hidden', '');
            }
        });

        async function loadComments(postId, listNode) {
            listNode.innerHTML = 'Загрузка...';
            const res = await fetch('/api/comments/' + postId, {method: 'GET'});
            if (!res.ok) {
                listNode.textContent = 'Ошибка загрузки';
                return;
            }
            const items = await res.json();
            renderComments(items, listNode);
        }

        function renderComments(items, listNode) {
            if (!items.length) {
                listNode.textContent = 'Пока нет комментариев';
                return;
            }
            listNode.innerHTML = '';
            for (const c of items) {
                const el = document.createElement('div');
                el.className = 'comment-row';
                el.setAttribute('data-comment-id', c.id);
                el.innerHTML =
                    '<strong>' + escapeHtml(c.authorUsername || '') + '</strong>' +
                    '<span>' + escapeHtml(c.text || '') + '</span>' +
                    (c.mine ? '<button type="button" class="delete-comment" data-del>Удалить</button>' : '');

            }
        }


        document.addEventListener('submit', async (e) => {
            const form = e.target.closest('[data-comment-form]');
            if (!form) return;
            const box = form.closest('[data-comments]');
            const postId = box.getAttribute('data-post-id');
            const listNode = box.querySelector('[data-comments-list]');
            const input = form.querySelector('input[name="text"]');
            const text = input.value.trim();
            if (!text) return;

            const res = await fetch('/api/comments/' + postId, {
                method: 'POST',
                headers: {'Content-Type': 'application/json', [header]: token},
                body: JSON.stringify({text})
            });
            if (!res.ok) {
                if (res.status === 401) return (window.location.href = '/auth/login');
                return alert('Не удалось добавить комментарий');
            }
            const dto = await res.json();


            const itemsNow = listNode.querySelectorAll('.comment-row').length;
            const row = document.createElement('div');
            row.className = 'comment-row';
            row.setAttribute('data-comment-id', dto.id);
            row.innerHTML =
                '<strong>' + escapeHtml(dto.authorUsername || '') + '</strong>' +
                '<span>' + escapeHtml(dto.text || '') + '</span>' +
                (dto.mine ? '<button type="button" class="delete-comment" data-del>Удалить</button>' : '');

            if (itemsNow === 0 && listNode.textContent === 'Пока нет комментариев') listNode.textContent = '';
            listNode.prepend(row);


            const stat = box.closest('.post-card').querySelector('.post-stats .link-btn[data-open-comments]');
            if (stat) {
                const m = stat.textContent.trim().match(/(\d+)/);
                const count = m ? parseInt(m[1], 10) : 0;
                stat.textContent = 'View all ' + (count + 1) + ' comments';
            }

            input.value = '';
        });


        document.addEventListener('click', async (e) => {
            const btn = e.target.closest('[data-del]');
            if (!btn) return;
            const row = btn.closest('.comment-row');
            const commentId = row.getAttribute('data-comment-id');
            if (!commentId) return;
            if (!confirm('Удалить комментарий?')) return;

            const res = await fetch('/api/comments/' + commentId, {
                method: 'DELETE',
                headers: {[header]: token}
            });
            if (!res.ok) {
                return alert('Не удалось удалить');
            }

            const box = row.closest('[data-comments]');
            const listNode = box.querySelector('[data-comments-list]');
            row.remove();


            const stat = box.closest('.post-card').querySelector('.post-stats .link-btn[data-open-comments]');
            if (stat) {
                const m = stat.textContent.trim().match(/(\d+)/);
                const count = m ? parseInt(m[1], 10) : 0;
                const next = Math.max(0, count - 1);
                stat.textContent = 'View all' + next + 'comments';
            }

            if (!listNode.querySelector('.comment-row')) {
                listNode.textContent = 'Пока нет комментариев';
            }
        });

        function escapeHtml(s) {
            return (s || '').replace(/[&<>"']/g, m => ({
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#39;'
            }[m]));
        }
    </script>

</@index.layout>