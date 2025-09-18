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
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
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
            <input type="file" id="avatarInput" name="avatar" accept="image/*" style="display: none;" onchange="previewAvatar()">
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
    <div class="publications">
        <div class="publications">
            <#list userProfileDto.posts as post>
                <div class="publication">
                    <img src="/api/images/image/${post.id}" alt="Публикация">
                    <div class="publication-caption">${post.description!""}</div>
                </div>
            </#list>
        </div>

    </div>
</div>

<script>
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
</script>
</body>

</@index.layout>
