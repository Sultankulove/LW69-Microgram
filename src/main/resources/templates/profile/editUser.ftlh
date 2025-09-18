<#import "../layout.ftlh" as main>

<@main.layout>
<!DOCTYPE html>
<#import "/spring.ftl" as spring>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Редактирование профиля</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:600&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(120deg, #89f7fe 0%, #66a6ff 100%);
            font-family: 'Montserrat', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .profile-form {
            background: #fff;
            padding: 2.5rem 2rem;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(102,166,255,0.2);
            width: 350px;
            text-align: center;
        }
        .profile-form h2 {
            margin-bottom: 1.5rem;
            color: #3578e5;
        }
        .avatar-preview {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: #e3eafc;
            margin: 0 auto 1rem;
            object-fit: cover;
            border: 3px solid #66a6ff;
            display: block;
        }
        .file-input {
            display: none;
        }
        .upload-label {
            display: inline-block;
            margin-bottom: 1.5rem;
            cursor: pointer;
            color: #fff;
            background: #66a6ff;
            padding: 0.5rem 1.2rem;
            border-radius: 20px;
            font-size: 0.95rem;
            transition: background 0.2s;
        }
        .upload-label:hover {
            background: #3578e5;
        }
        .profile-form input, .profile-form textarea {
            width: 100%;
            padding: 0.7rem;
            margin-bottom: 1rem;
            border: 1px solid #dbeafe;
            border-radius: 8px;
            font-size: 1rem;
            background: #f7fbff;
            transition: border 0.2s;
        }
        .profile-form input:focus, .profile-form textarea:focus {
            border: 1.5px solid #66a6ff;
            outline: none;
        }
        .profile-form button {
            width: 100%;
            padding: 0.8rem;
            background: linear-gradient(90deg, #66a6ff 0%, #3578e5 100%);
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .profile-form button:hover {
            background: linear-gradient(90deg, #3578e5 0%, #66a6ff 100%);
        }
        .profile-form label {
            display: block;
            text-align: left;
            margin-bottom: 0.3rem;
            color: #3578e5;
            font-size: 0.97rem;
            font-weight: 600;
        }
    </style>
</head>
<body>


<form class="profile-form" method="post" action="/auth/update" enctype="multipart/form-data">
    <#if _csrf??>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </#if>

    <h2>Редактировать профиль</h2>






    <label for="displayName">Имя</label>
    <input type="text" id="displayName" name="displayName" value="${userUpdateDto.displayName!}" required>

    <label for="username">Имя пользователя</label>
    <input type="text" id="username" name="name" value="${userUpdateDto.name!}" required>

    <label for="bio">Биография</label>
    <textarea id="bio" name="bio" rows="3">${userUpdateDto.bio!}</textarea>

    <button type="submit">Сохранить</button>
</form>

</body>
</html>

</@main.layout>