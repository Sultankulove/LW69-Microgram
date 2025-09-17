<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Microgram Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            background: #fafafa;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-container {
            background: #fff;
            border: 1px solid #dbdbdb;
            padding: 40px 40px 24px 40px;
            width: 350px;
            display: flex;
            flex-direction: column;
            align-items: center;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .logo {
            font-family: 'Segoe Script', cursive;
            font-size: 2.5rem;
            color: #262626;
            margin-bottom: 32px;
            letter-spacing: 2px;
        }
        .login-form {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .login-form input {
            padding: 10px;
            border: 1px solid #dbdbdb;
            border-radius: 4px;
            background: #fafafa;
            font-size: 1rem;
            outline: none;
        }
        .login-form button {
            margin-top: 12px;
            padding: 10px;
            background: #3897f0;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.2s;
        }
        .login-form button:disabled {
            background: #b2dffc;
            cursor: not-allowed;
        }
        .divider {
            width: 100%;
            text-align: center;
            margin: 18px 0;
            color: #999;
            font-size: 0.9rem;
            position: relative;
        }
        .divider:before, .divider:after {
            content: '';
            display: inline-block;
            width: 40%;
            height: 1px;
            background: #dbdbdb;
            vertical-align: middle;
            margin: 0 8px;
        }
        .signup-link {
            margin-top: 24px;
            font-size: 1rem;
            color: #262626;
        }
        .signup-link a {
            color: #3897f0;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="logo">Microgram</div>
    <form class="login-form">
        <input type="text" placeholder="Phone number, username, or email" required>
        <input type="password" placeholder="Password" required>
        <button type="submit">Log In</button>
    </form>
    <div class="divider">OR</div>
    <div class="signup-link">
        Don't have an account? <a href="#">Sign up</a>
    </div>
</div>
</body>
</html>