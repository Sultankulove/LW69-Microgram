<#import "spring.ftl" as spring>
<#macro layout>

<!DOCTYPE html>
<html lang="en" class="h-100"></html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title!"Microgram"}</title>
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .wrapper {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        main {
            flex: 1 0 auto;
        }
        footer {
            flex-shrink: 0;
            border-top: 1px solid #dbdbdb;
        }
        .header {
            border-bottom: 1px solid #dbdbdb;
            background-color: white;
        }
        .nav-link {
            color: black;
        }
        .logo {
            font-size: 24px;
            font-weight: 700;
            color: #3578e5;
            text-decoration: none;
        }
        .logo:hover {
            color: #66a6ff;
        }
    </style>
</head>
<body class="h-100">
<div class="wrapper">
    <header class="header py-2 fixed-top">
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <a class="logo" href="/">Microgram</a>
                </div>
                <div class="col text-center">
                    <form class="d-flex justify-content-center">
                        <input class="form-control w-50" type="search" placeholder="Search" aria-label="Search">
                    </form>
                </div>
                <div class="col text-end">
                    <nav>
                        <a href="/" class="nav-link d-inline-block mx-2"><i class="fas fa-home"></i></a>
<#--                        <a href="#" class="nav-link d-inline-block mx-2"><i class="far fa-paper-plane"></i></a>-->
                        <a href="/post" class="nav-link d-inline-block mx-2"><i class="far fa-plus-square"></i></a>
<#--                        <a href="#" class="nav-link d-inline-block mx-2"><i class="far fa-compass"></i></a>-->
                        <a href="/auth/profile" class="nav-link d-inline-block mx-2"><i class="far fa-user"></i></a>
                    </nav>
                </div>
            </div>
        </div>
    </header>

    <main class="container mt-5 pt-4">
        <#nested spring>
    </main>

    <footer class="footer bg-light py-3 border-top">
        <div class="container text-center">
            <span class="text-muted">© 2023 Microgram. All rights reserved.</span>
        </div>
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/main.js"></script>
</body>
</html>

</#macro>