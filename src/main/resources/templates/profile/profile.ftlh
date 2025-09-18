<!DOCTYPE html>
<html lang="ru">
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
    </style>
</head>
<body>
<div class="profile-container">
    <div class="profile-header">
        <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Аватар" class="avatar">
        <div class="profile-info">
            <div class="profile-login">${userProfileDto.displayName}</div>
            <div class="profile-stats">
                <div class="profile-stat"><span>3</span> публикации</div>
                <div class="profile-stat"><span>120</span> подписчиков</div>
                <div class="profile-stat"><span>85</span> подписки</div>
            </div>
            <div class="profile-name">${userProfileDto.username}</div>
            <div class="profile-bio">${userProfileDto.bio}</div>
            <button class="edit-btn">Редактировать профиль</button>
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
</body>
</html>
