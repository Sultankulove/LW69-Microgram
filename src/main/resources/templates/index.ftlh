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

            .post-header .post-time {
                margin-left: auto;
                font-size: .8em;
                color: #999;
            }

            .post-card {
                background: #fff;
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

            .post-card .comments-list {
                padding: 6px 12px 10px
            }

            .post-card .comment-row {
                display: flex;
                align-items: flex-start;
                gap: .5rem;
                padding: 6px 0;
                font-size: 14px;
                line-height: 1.35;
                border-bottom: 1px solid #f2f2f2;
            }

            .post-card .comment-row:last-child {
                border-bottom: none
            }

            .post-card .comment-row strong {
                font-weight: 600
            }

            .post-card .comment-row span {
                color: #111
            }

            .post-card .delete-comment {
                margin-left: auto;
                background: transparent;
                border: 0;
                padding: 2px 6px;
                font-size: 12px;
                color: #000;
                opacity: .25;
                cursor: pointer;
            }

            .post-card .delete-comment:hover {
                opacity: .85;
                text-decoration: underline
            }

            .post-card .comment-form {
                display: flex;
                gap: .5rem;
                padding: 8px 12px 12px
            }

            .post-card .comment-form input {
                flex: 1;
                border: 0;
                border-bottom: 1px solid #e5e5e5;
                outline: none;
                padding: 6px 0;
            }

            .post-card .comment-form button {
                border: 0;
                background: #0095f6;
                color: #fff;
                border-radius: 6px;
                padding: 6px 10px;
            }

            .ig-modal[hidden] {
                display: none
            }

            .ig-modal {
                position: fixed;
                inset: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 1050;
            }

            .ig-modal .backdrop {
                position: absolute;
                inset: 0;
                background: rgba(0, 0, 0, .45);
            }

            .ig-modal .dialog {
                position: relative;
                background: #fff;
                width: min(92vw, 420px);
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, .25);
                overflow: hidden;
                z-index: 1;
            }

            .ig-modal .dialog header {
                padding: 14px 16px;
                font-weight: 600;
                border-bottom: 1px solid #eee
            }

            .ig-modal .dialog .body {
                padding: 16px;
                color: #444
            }

            .ig-modal .dialog .actions {
                display: flex;
                gap: .5rem;
                justify-content: flex-end;
                padding: 12px 16px;
                border-top: 1px solid #eee
            }

            .ig-modal .btn {
                padding: 6px 12px;
                border-radius: 8px;
                border: 0;
                cursor: pointer
            }

            .ig-modal .btn.gray {
                background: #efefef
            }

            .ig-modal .btn.danger {
                background: #ed4956;
                color: #fff
            }

            a {
                color: inherit;
                text-decoration: none;
            }

            a:hover, a:focus {
                text-decoration: none;
                color: inherit;
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


                        <a href="<#if post.author.id == userId>/auth/profile<#else>/auth/profile/${post.author.id}</#if>">
                            <strong>${post.author.username!''}</strong>
                        </a>


                        <#if post.author.id != userId && !post.followedByMe>
                            <div class="post-actions">
                                <button class="follow-btn" data-user-id="${post.author.id}">Подписаться</button>
                            </div>
                        </#if>

                    </div>

                    <#--                    <div class="post-actions">-->
                    <#--                    </div>-->

                    <div class="post-image-wrapper">
                        <img src="${imageSrc}" alt="${post.description!'Post image'}" class="post-image">
                    </div>

                    <div class="post-actions">
                        <i class="${post.likedByMe?then('fas','far')} fa-heart"
                           data-post-id="${post.id}" data-liked="${post.likedByMe?c}"
                           onclick="likePost(this)"></i>
                        <i class="far fa-comment ms-3" role="button" tabindex="0"
                           data-open-comments data-post-id="${post.id}" title="Комментарии"></i>
                    </div>

                    <div class="post-stats">
                        <strong data-like-count>${post.likesCount!0} likes</strong>
                    </div>

                    <div class="post-description">
                        <strong>${post.author.username!''}</strong> ${post.description!''}
                    </div>

                    <div class="post-stats">
            <span class="link-btn" data-open-comments data-post-id="${post.id}">
                View all ${post.commentsCount!0} comments
            </span>
                    </div>

                    <div class="post-stats" data-comments data-post-id="${post.id}" hidden>
                        <div class="comments-list" data-comments-list></div>
                        <form class="comment-form" data-comment-form onsubmit="return false;">
                            <label><input type="text" name="text" maxlength="1000" placeholder="Добавьте комментарий…"/></label>
                            <button type="submit">Отправить</button>
                        </form>
                    </div>
                </div>
            </#list>

        </div>
    </div>

    <div class="ig-modal" id="confirmDelete" hidden>
        <div class="backdrop" data-cancel></div>
        <div class="dialog">
            <header>Удалить комментарий?</header>
            <div class="body">Действие нельзя отменить.</div>
            <div class="actions">
                <button class="btn gray" type="button" data-cancel>Отмена</button>
                <button class="btn danger" type="button" data-confirm>Удалить</button>
            </div>
        </div>
    </div>


    <script>

        const CSRF_TOKEN = document.querySelector('meta[name="_csrf"]')?.content;
        const CSRF_HEADER = document.querySelector('meta[name="_csrf_header"]')?.content || 'X-CSRF-TOKEN';


        function likePost(elem) {
            const postId = elem.getAttribute("data-post-id");
            if (!postId) return;
            if (elem.dataset.busy === '1') return;
            elem.dataset.busy = '1';

            const liked = elem.dataset.liked === 'true';

            fetch('/api/likes/' + postId, {
                method: liked ? 'DELETE' : 'POST',
                headers: {[CSRF_HEADER]: CSRF_TOKEN}
            })
                .then(res => {
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
                })
                .catch(() => alert('Сеть недоступна'))
                .finally(() => {
                    elem.dataset.busy = '0';
                });
        }

        document.addEventListener('click', async (e) => {
            const btn = e.target.closest('[data-open-comments]');
            if (!btn) return;

            const postCard = btn.closest('.post-card');
            const box = postCard.querySelector('[data-comments]');
            const statLine = postCard.querySelector('.post-stats .link-btn[data-open-comments]');
            if (box.hasAttribute('hidden')) {
                await loadComments(btn.dataset.postId, box.querySelector('[data-comments-list]'));
                box.removeAttribute('hidden');
                if (statLine) statLine.style.display = 'none';
            } else {
                box.setAttribute('hidden', '');
                if (statLine) statLine.style.display = '';
            }
        });

        async function loadComments(postId, listNode) {
            listNode.textContent = 'Загрузка...';
            const res = await fetch('/api/comments/' + postId, {method: 'GET'});
            if (!res.ok) {
                listNode.textContent = 'Ошибка загрузки';
                return;
            }
            const items = await res.json();
            renderComments(items, listNode);
        }

        function renderComments(items, listNode) {
            if (!items || !items.length) {
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
                listNode.appendChild(el);
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
                headers: {'Content-Type': 'application/json', [CSRF_HEADER]: CSRF_TOKEN},
                body: JSON.stringify({text})
            });
            if (!res.ok) {
                if (res.status === 401) return (window.location.href = '/auth/login');
                return alert('Не удалось добавить комментарий');
            }
            const dto = await res.json();

            if (listNode.textContent === 'Пока нет комментариев') listNode.textContent = '';
            const row = document.createElement('div');
            row.className = 'comment-row';
            row.setAttribute('data-comment-id', dto.id);
            row.innerHTML =
                '<strong>' + escapeHtml(dto.username || '') + '</strong>' +
                '<span>' + escapeHtml(dto.text || '') + '</span>' +
                (dto.mine ? '<button type="button" class="delete-comment" data-del>Удалить</button>' : '');
            listNode.prepend(row);

            const stat = box.closest('.post-card').querySelector('.post-stats .link-btn[data-open-comments]');
            if (stat) {
                const m = stat.textContent.trim().match(/(\d+)/);
                const count = m ? parseInt(m[1], 10) : 0;
                stat.textContent = 'View all ' + (count + 1) + ' comments';
            }

            input.value = '';
        });

        const modal = document.getElementById('confirmDelete');
        const btnOK = modal?.querySelector('[data-confirm]');
        const btnNo = modal?.querySelector('[data-cancel]');
        let toDelete = null;

        function openModal(payload) {
            toDelete = payload;
            if (modal) modal.hidden = false;
        }

        function closeModal() {
            if (modal) modal.hidden = true;
            toDelete = null;
        }


        document.addEventListener('click', (e) => {
            const del = e.target.closest('[data-del]');
            if (!del) return;
            const row = del.closest('.comment-row');
            const commentId = row?.getAttribute('data-comment-id');
            if (row && commentId) openModal({row, commentId});
        });


        modal?.addEventListener('click', (e) => {
            if (e.target.matches('[data-cancel], .backdrop[data-cancel]')) closeModal();
        });
        btnNo?.addEventListener('click', closeModal);


        btnOK?.addEventListener('click', async () => {
            if (!toDelete) return;
            const {row, commentId} = toDelete;

            const res = await fetch('/api/comments/' + commentId, {
                method: 'DELETE',
                headers: {[CSRF_HEADER]: CSRF_TOKEN}
            });
            if (!res.ok) {
                alert('Не удалось удалить');
                return;
            }

            const box = row.closest('[data-comments]');
            const listNode = box.querySelector('[data-comments-list]');
            row.remove();

            const stat = box.closest('.post-card').querySelector('.post-stats .link-btn[data-open-comments]');
            if (stat) {
                const m = stat.textContent.trim().match(/(\d+)/);
                const count = m ? parseInt(m[1], 10) : 0;
                stat.textContent = 'View all ' + Math.max(0, count - 1) + ' comments';
            }

            if (!listNode.querySelector('.comment-row')) listNode.textContent = 'Пока нет комментариев';
            closeModal();
        });

        function escapeHtml(s) {
            return (s || '').replace(/[&<>"']/g, m => ({
                '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;'
            }[m]));
        }


        // document.querySelectorAll('.follow-btn').forEach(button => {
        //     button.addEventListener('click', function () {
        //         const userId = this.dataset.userId;
        //         fetch('/auth/follow/' + userId, {
        //             method: 'POST',
        //             headers: {[CSRF_HEADER]: CSRF_TOKEN}
        //         })
        //             .then(res => res.json())
        //             .then(data => {
        //                 this.textContent = data.following ? 'Отписаться' : 'Подписаться';
        //             });
        // document.querySelectorAll('.follow-btn').forEach(button => {
        //     button.addEventListener('click', function() {
        //         const userId = this.dataset.userId;
        //         fetch('/auth/follow/' + userId, {
        //             method: 'POST',
        //             headers: { [CSRF_HEADER]: CSRF_TOKEN }
        //         })
        //             .then(res => res.json())
        //             .then(data => {
        //                 this.textContent = data.following ? 'Отписаться' : 'Подписаться';
        //             });
        //     });
        // });

        document.querySelectorAll('.follow-btn').forEach(button => {
            button.addEventListener('click', function () {
                const userId = this.dataset.userId;
                fetch('/auth/follow/' + userId, {
                    method: 'POST',
                    headers: {[CSRF_HEADER]: CSRF_TOKEN}
                })
                    .then(res => res.json())
                    .then(data => {
                        // Меняем текст кнопки в зависимости от того, подписан ли сейчас
                        this.textContent = data.following ? 'Отписаться' : 'Подписаться';
                    });
            });
        });
        //     });
        // });


    </script>
</@index.layout>
