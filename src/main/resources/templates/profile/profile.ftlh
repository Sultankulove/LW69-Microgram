<#import "../layout.ftlh" as index>
<@index.layout>

    <head>
        <meta charset="UTF-8">
        <title>Личный кабинет | Microgram</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            body {
                background: #f0f2f5;
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }

            .profile-container {
                max-width: 700px;
                margin: 60px auto;
                background: #fff;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 36px 32px 24px 32px;
                box-sizing: border-box;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
            }

            .profile-header {
                display: flex;
                align-items: center;
                margin-bottom: 28px;
            }

            .avatar {
                width: 96px;
                height: 96px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #38a1db;
                margin-right: 32px;
            }

            .profile-info {
                flex: 1;
            }

            .profile-login {
                font-size: 22px;
                font-weight: bold;
                color: #222;
                margin-bottom: 8px;
            }

            .profile-stats {
                display: flex;
                gap: 28px;
                margin-bottom: 10px;
            }

            .profile-stat {
                font-size: 15px;
                color: #444;
            }

            .profile-stat span {
                font-weight: bold;
                color: #222;
                margin-right: 4px;
            }

            .profile-name {
                font-size: 18px;
                color: #444;
                margin-bottom: 6px;
            }

            .profile-bio {
                font-size: 15px;
                color: #666;
                margin-bottom: 10px;
            }

            .edit-btn {
                background: #38a1db;
                color: #fff;
                border: none;
                padding: 8px 18px;
                border-radius: 4px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
            }

            .publications-title {
                font-size: 18px;
                font-weight: 600;
                color: #333;
                margin: 32px 0 18px 0;
            }

            .publications {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
                gap: 18px;
            }

            .publication {
                background: #fafafa;
                border: 1px solid #e0e0e0;
                border-radius: 6px;
                overflow: hidden;
                display: flex;
                flex-direction: column;
            }

            .publication img {
                width: 100%;
                height: 160px;
                object-fit: cover;
            }

            .publication-caption {
                padding: 10px;
                font-size: 14px;
                color: #444;
            }

            .profile-button {
                display: inline-block;
                padding: 0.6rem 1.2rem;
                background: linear-gradient(90deg, #66a6ff 0%, #3578e5 100%);
                color: #fff;
                border-radius: 20px;
                font-weight: 600;
                text-decoration: none;
                transition: background 0.2s;
                margin-top: 1rem;
            }

            .profile-button:hover {
                background: linear-gradient(90deg, #3578e5 0%, #66a6ff 100%);
            }


            .pub-grid {
                display: grid;
                grid-template-columns:repeat(3, 1fr);
                gap: 8px;
                margin-top: 12px;
            }

            @media (max-width: 768px) {
                .pub-grid {
                    grid-template-columns:repeat(3, 1fr);
                    gap: 4px;
                }
            }

            @media (max-width: 480px) {
                .pub-grid {
                    grid-template-columns:repeat(2, 1fr);
                }
            }

            .pub-item {
                position: relative;
                border-radius: 6px;
                overflow: hidden;
                background: #f2f2f2;
                cursor: pointer;
                aspect-ratio: 1/1;
            }

            .pub-item img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }


            .pub-overlay {
                position: absolute;
                inset: 0;
                background: rgba(0, 0, 0, .35);
                color: #fff;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 18px;
                font-weight: 700;
                opacity: 0;
                transition: opacity .18s ease;
            }

            .pub-item:hover .pub-overlay {
                opacity: 1;
            }

            .pub-overlay i {
                margin-right: 6px;
            }


            .pub-caption {
                font-size: 13px;
                color: #444;
                padding: 6px 2px 0;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }


            .lightbox {
                position: fixed;
                inset: 0;
                background: rgba(0, 0, 0, .85);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 9999;
                padding: 20px;
            }

            .lightbox[hidden] {
                display: none;
            }

            .lightbox img {
                max-width: 90vw;
                max-height: 85vh;
                border-radius: 8px;
            }

            .lightbox .close {
                position: absolute;
                top: 18px;
                right: 22px;
                color: #fff;
                font-size: 28px;
                line-height: 1;
                cursor: pointer;
            }

            .delete-post-btn {
                position: absolute;
                top: 8px;
                right: 8px;
                background: rgba(0, 0, 0, .25);
                color: #fff;
                border: 0;
                padding: 6px 10px;
                border-radius: 6px;
                font-size: 12px;
                opacity: .6;
                transition: opacity .15s ease;
                z-index: 10;
            }

            .delete-post-btn:hover {
                opacity: 1;
            }

            .modal-backdrop{
                position:fixed; inset:0;
                background:rgba(0,0,0,.5);
                display:flex; align-items:center; justify-content:center;
                z-index:10000;
            }
            .modal-backdrop[hidden]{ display:none; }

            .modal-card{
                width:320px; max-width:90vw;
                background:#fff; border-radius:10px;
                box-shadow:0 10px 30px rgba(0,0,0,.25);
                overflow:hidden;
            }
            .modal-card .modal-header{
                padding:14px 16px; font-weight:700; border-bottom:1px solid #eee;
            }
            .modal-card .modal-body{
                padding:14px 16px; color:#333;
            }
            .modal-card .modal-actions{
                display:flex; gap:8px; justify-content:flex-end;
                padding:12px 16px; border-top:1px solid #eee;
            }
            .modal-card .btn{
                padding:6px 12px; border-radius:6px; border:0; cursor:pointer;
            }
            .modal-card .btn-cancel{ background:#e9ecef; color:#222; }
            .modal-card .btn-danger{ background:#e03131; color:#fff; }
        </style>
    </head>
    <body>
    <div class="profile-container">
        <div class="profile-header">


            <form id="avatarForm" action="/api/images/avatar" method="post" enctype="multipart/form-data">
                <label for="avatarInput" style="cursor: pointer;">
                    <img id="avatarPreview"
                         src="<#if userProfileDto.avatar?? && userProfileDto.avatar?has_content>
              /api/images/avatar
          <#else>
              /avatar/default.jpg
          </#if>"
                         alt="Avatar"
                         class="avatar">
                </label>
                <input type="file" id="avatarInput" name="avatar" accept="image/*" style="display: none;"
                       onchange="previewAvatar()">
            </form>

            <div class="profile-info">
                <div class="profile-login">${userProfileDto.displayName}</div>
                <h4>${userProfileDto.email}</h4>
                <div class="profile-stats">

                    <span class="profile-stat">${userProfileDto.posts?size} публикации</span>
                    <div class="profile-stat"><span>${userProfileDto.followersCount}</span> подписчиков</div>
                    <div class="profile-stat"><span>${userProfileDto.followingCount}</span> подписки</div>

                </div>
                <div class="profile-name">${userProfileDto.username}</div>
                <#if userProfileDto.bio?? && (userProfileDto.bio?has_content)>
                    <div class="profile-bio">${userProfileDto.bio}</div>
                </#if>


                <a class="profile-button" href="/auth/update">Редактировать профиль</a>


            </div>
        </div>


        <div class="publications-title">Публикации</div>

        <div class="pub-grid">
            <#list userProfileDto.posts as post>
                <div class="pub-item"
                     data-open-lightbox
                     data-img="/api/images/image/${post.id}"
                     title="Открыть публикацию">
                    <button type="button" class="delete-post-btn" data-del-post data-post-id="${post.id}">Удалить
                    </button>

                    <img src="/api/images/image/${post.id}" alt="Публикация ${post?index + 1}"/>

                    <div class="pub-overlay">
                        <span><i class="fa-solid fa-heart"></i>${post.likesCount!0}</span>
                        <span><i class="fa-solid fa-comment"></i>${post.commentsCount!0}</span>
                    </div>
                </div>
            </#list>
        </div>
    </div>
    <div id="lightbox" class="lightbox" hidden>
        <span class="close" aria-label="Закрыть">&times;</span>
        <img id="lightboxImg" src="" alt=""/>
    </div>

    <div id="deleteModal" class="modal-backdrop" hidden>
        <div class="modal-card" role="dialog" aria-modal="true" aria-labelledby="delTitle">
            <div class="modal-header" id="delTitle">Удалить публикацию?</div>
            <div class="modal-body">Это действие нельзя отменить.</div>
            <div class="modal-actions">
                <button type="button" class="btn btn-cancel" data-modal-cancel>Отмена</button>
                <button type="button" class="btn btn-danger" data-modal-confirm>Удалить</button>
            </div>
        </div>
    </div>

    <script>
        const CSRF_TOKEN  = document.querySelector('meta[name="_csrf"]')?.content;
        const CSRF_HEADER = document.querySelector('meta[name="_csrf_header"]')?.content || 'X-CSRF-TOKEN';

        function previewAvatar() {
            const input = document.getElementById("avatarInput");
            const preview = document.getElementById("avatarPreview");
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);

                document.getElementById("avatarForm").submit();
            }
        }

        document.addEventListener('click', (e) => {
            const modalOpen = !document.getElementById('deleteModal').hidden;
            if (modalOpen) return;

            if (e.target.closest('[data-del-post]')) return;

            const item = e.target.closest('[data-open-lightbox]');
            if (!item) return;

            const src = item.getAttribute('data-img');
            const lb  = document.getElementById('lightbox');
            const img = document.getElementById('lightboxImg');
            img.src = src;
            lb.hidden = false;
        });


        document.getElementById('lightbox').addEventListener('click', (e) => {
            if (e.target.id === 'lightbox' || e.target.classList.contains('close')) {
                e.currentTarget.hidden = true;
                document.getElementById('lightboxImg').src = '';
            }
        });
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                const lb = document.getElementById('lightbox');
                if (!lb.hidden) lb.hidden = true;
            }
        });

        const modal   = document.getElementById('deleteModal');
        const btnYes  = modal.querySelector('[data-modal-confirm]');
        const btnNo   = modal.querySelector('[data-modal-cancel]');
        let pending = { postId: null, button: null };

        function openDeleteModal(postId, button){
            pending = { postId, button };
            modal.hidden = false;
        }
        function closeDeleteModal(){
            modal.hidden = true;
            pending = { postId: null, button: null };
        }

        document.addEventListener('click', (e) => {
            const btn = e.target.closest('[data-del-post]');
            if (!btn) return;

            e.stopPropagation();
            e.preventDefault();

            const id = btn.getAttribute('data-post-id');
            openDeleteModal(id, btn);
        });

        modal.addEventListener('click', (e) => {
            const card = e.target.closest('.modal-card');
            if (!card || e.target.matches('[data-modal-cancel]')) {
                closeDeleteModal();
            }
        });

        btnYes.addEventListener('click', async () => {
            if (!pending.postId) return;

            try {
                const res = await fetch('/api/posts/' + pending.postId, {
                    method: 'DELETE',
                    headers: { [CSRF_HEADER]: CSRF_TOKEN }
                });

                if (res.status === 204) {
                    pending.button.closest('.pub-item')?.remove();
                    closeDeleteModal();
                } else if (res.status === 403) {
                    alert('Нельзя удалить чужую публикацию');
                } else if (res.status === 404) {
                    alert('Публикация не найдена');
                } else {
                    alert('Ошибка удаления');
                }
            } catch (e) {
                alert('Сеть недоступна');
            }
        });
    </script>
    </body>

</@index.layout>
