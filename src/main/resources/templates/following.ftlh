<#import "./layout.ftlh" as index>
<@index.layout>
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <title>Подписчики</title>
        <style>
            body {
                background: #fafafa;
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                padding-top: 50px;
            }
            .subscribe-box {
                background: #fff;
                border: 1px solid #dbdbdb;
                border-radius: 8px;
                padding: 40px 30px 20px 30px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.04);
                width: 340px;
                text-align: center;
            }
            .header {
                display: flex;
                align-items: center;
                gap: 15px;
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 1px solid #efefef;
            }
            .owner-avatar {
                width: 56px;
                height: 56px;
                border-radius: 50%;
                border: 2px solid #dbdbdb;
                object-fit: cover;
            }
            .owner-name {
                font-size: 20px;
                font-weight: bold;
                color: #262626;
            }
            .followers-list {
                margin-top: 25px;
                text-align: left;
            }
            .follower {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 10px;
            }
            .follower img {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                border: 1px solid #dbdbdb;
            }
            .follower span {
                font-size: 15px;
                color: #262626;
            }
        </style>
    </head>
    <body>
    <div class="subscribe-box">
        <div class="header">
            <img class="owner-avatar"
                 src="<#if owner.id??>
                    /api/images/avatar/${owner.id}
                  <#else>
                    /images/default.jpg
                  </#if>"
                 alt="Владелец">
            <span class="owner-name">${owner.displayName!owner.name!''}</span>
        </div>

        Подписки

        <div class="followers-list" id="followingList">
            <#list following as f>
                <div class="follower">
                    <img src="<#if f.id??>
                             /api/images/avatar/${f.id}
                          <#else>
                             /images/default.jpg
                          </#if>"
                         alt="${f.name}">
                    <span>${f.displayName!f.name!''}</span>
                </div>
            </#list>
        </div>
    </div>


    </body>
    </html>
</@index.layout>