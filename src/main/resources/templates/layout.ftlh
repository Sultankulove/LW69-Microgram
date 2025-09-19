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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
    <style>

        .search-wrap { width: 560px; max-width: 90vw; }
        .search-input { width: 100%; }

        .search-results {
            position: absolute;
            top: calc(100% + 6px);
            left: 0;
            width: 100%;
            max-height: 360px;
            overflow-y: auto;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            z-index: 1000;
        }

        .search-results .list-group-item {
            border: 0;
            border-bottom: 1px solid #eee;
            padding: 10px 12px;
        }
        .search-results .list-group-item:last-child { border-bottom: 0; }
        .search-results .list-group-item:hover { background: #f7f7f7; }


        #searchResults {
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 6px;
            overflow: hidden;
        }
        #searchResults .list-group-item {
            border: none;
            border-bottom: 1px solid #eee;
            padding: 8px 12px;
        }
        #searchResults .list-group-item:last-child {
            border-bottom: none;
        }
        #searchResults .list-group-item:hover {
            background: #f8f8f8;
        }

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
            <#assign _auth = (SPRING_SECURITY_CONTEXT.authentication)!>
            <#assign _isAuth = (_auth?? && _auth.principal?has_content && _auth.principal != 'anonymousUser')>

            <div class="row align-items-center">
                <div class="col">
                    <a class="logo" href="/">Microgram</a>
                </div>


                <div class="col d-flex justify-content-center">
                    <div class="search-wrap position-relative">
                        <form class="m-0" onsubmit="return false;">
                            <input id="userSearch" class="form-control search-input"
                                   type="search" placeholder="Search users..." aria-label="Search">
                        </form>

                        <div id="searchResults" class="list-group search-results shadow"
                             style="display:none;"></div>
                    </div>
                </div>

                <div class="col text-end">
                    <nav>
                        <form action="/logout" method="post">
                            <#if _csrf??>
                                <input
                                        type="hidden"
                                        name="${(_csrf.parameterName)!'csrf-param-name'}"
                                        value="${(_csrf.token)!'csrf-token'}"/>

                            </#if>
                        <a href="/" class="nav-link d-inline-block mx-2"><i class="fas fa-home"></i></a>
<#--                        <a href="#" class="nav-link d-inline-block mx-2"><i class="far fa-paper-plane"></i></a>-->
                        <a href="<#if _isAuth>/post<#else>/auth/login</#if>"
                           class="nav-link d-inline-block mx-2">
                            <i class="far fa-plus-square">

                            </i></a>
<#--                        <a href="#" class="nav-link d-inline-block mx-2"><i class="far fa-compass"></i></a>-->

                            <a href="<#if _isAuth>/auth/profile<#else>/auth/login</#if>"
                               class="nav-link d-inline-block mx-2">
                                <i class="far fa-user"></i>
                            </a>

<#--                        <a href="/auth/profile" class="nav-link d-inline-block mx-2"><i class="far fa-user"></i></a>-->
                            <#if _isAuth>
                                <button type="submit" class="nav-link d-inline-block mx-2">
                                    <i class="bi bi-box-arrow-right"></i>
                                </button>
                            </#if>
                        </form>

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

    <script>
        const input = document.getElementById('userSearch');
        const resultsBox = document.getElementById('searchResults');

        function showResults() { resultsBox.style.display = 'block'; }
        function hideResults() { resultsBox.style.display = 'none'; }

        input.addEventListener('input', async () => {
            const q = input.value.trim();
            if (!q) { hideResults(); resultsBox.innerHTML=''; return; }

            const res = await fetch('/api/users/search?q=' + encodeURIComponent(q));
            if (!res.ok) return;
            const users = await res.json();

            if (!users.length) {
                resultsBox.innerHTML = '<div class="list-group-item text-muted">Нет пользователей</div>';
            } else {
                var html = '';
                for (var i=0;i<users.length;i++){
                    var u = users[i];
                    html += '<a href="/auth/profile/' + u.id + '" class="list-group-item list-group-item-action d-flex align-items-center">'
                        + '<img src="' + (u.avatar ? '/api/images/avatar/' + u.id : '/static/img/default-avatar.png') + '"'
                        + ' style="width:32px;height:32px;border-radius:50%;object-fit:cover;margin-right:10px;">'
                        + '<div>'
                        +   '<div class="fw-bold">' + (u.displayName || '') + '</div>'
                        +   '<div class="text-muted small">@' + u.username + '</div>'
                        + '</div>'
                        + '</a>';
                }
                resultsBox.innerHTML = html;
            }
            showResults();
        });

        document.addEventListener('click', function(e){
            if (!resultsBox.contains(e.target) && e.target !== input) hideResults();
        });
    </script>


    </html>

</#macro>
