    <!DOCTYPE html>
    <#import "/spring.ftl" as spring>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <title>Регистрация в Microgram</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            body {
                background: #f0f2f5;
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 350px;
                margin: 60px auto;
                background: #fff;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 36px 32px 24px 32px;
                box-sizing: border-box;
                box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            }
            .logo {
                display: block;
                margin: 0 auto 28px auto;
                width: 120px;
            }
            h2 {
                text-align: center;
                color: #444;
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 22px;
            }
            form input {
                width: 100%;
                padding: 10px 8px;
                margin-bottom: 12px;
                border: 1px solid #ccc;
                border-radius: 3px;
                background: #fafafa;
                font-size: 15px;
            }
            .register-btn {
                width: 100%;
                background: #38a1db;
                color: #fff;
                border: none;
                padding: 10px 0;
                border-radius: 4px;
                font-size: 15px;
                font-weight: bold;
                cursor: pointer;
                margin-top: 8px;
            }
            .register-btn:disabled {
                opacity: 0.6;
                cursor: default;
            }
            .login-link {
                display: block;
                text-align: center;
                margin-top: 18px;
                color: #38a1db;
                text-decoration: none;
                font-size: 14px;
            }
            .login-link:hover {
                text-decoration: underline;
            }
            .terms {
                color: #888;
                font-size: 12px;
                text-align: center;
                margin-top: 16px;
                line-height: 1.5;
            }
        </style>
    </head>
    <body>
    <div class="container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/9/95/Instagram_logo_2022.svg" alt="Microgram" class="logo">
        <h2>Регистрация в Microgram</h2>
        <form  class="login-form" method="post" action="/auth/register">
            <#if _csrf??>
                <input
                        type="hidden"
                        name="${(_csrf.parameterName)!'csrf-param-name'}"
                        value="${(_csrf.token)!'csrf-token'}"/>
            </#if>

            <label class="form-label" for="username">Имя пользователя</label>
            <@spring.formInput "userRegisterDto.username" 'id="username" class="form-control form-control-lg" placeholder="Введите имя пользователя"' />
            <@spring.showErrors "<br>" "error text-danger" />

            <label class="form-label" for="username1">Имя фамилия</label>
            <@spring.formInput "userRegisterDto.displayName" 'id="username1" class="form-control form-control-lg" placeholder="Введите имя фамилия"' />
            <@spring.showErrors "<br>" "error text-danger" />


            <label class="form-label" for="form3Example3cg">Email</label>
            <@spring.formInput
            "userRegisterDto.email"
            'id="form3Example3cg" class="form-control form-control-lg" placeholder="Введите ваш email"'
            />
            <@spring.showErrors "<br>" "error text-danger" />




            <label class="form-label" for="form3Example3cg">Password</label>
            <@spring.formInput "userRegisterDto.password" 'id="form3Example3cg" class="form-control form-control-lg"placeholder="Введите пароль"' />
            <@spring.showErrors "<br>" "error text-danger" />


            <button type="submit" class="register-btn">Зарегистрироваться</button>
        </form>
        <a href="auth/login" class="login-link">Уже есть аккаунт? Войти</a>
        <div class="terms">
            Регистрируясь, вы принимаете <a href="#" style="color:#38a1db;">условия использования</a> и <a href="#" style="color:#38a1db;">политику конфиденциальности</a>.
        </div>
    </div>
    </body>
    </html>
