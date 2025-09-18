<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    </style>
</head>
<body>

<div class="container">
    <div id="posts-container">
        <#list posts as post>
            <div class="post-card">
                <div class="post-header">
                    <img src="/api/images/avatar/${post.author.id!'https://as2.ftcdn.net/v2/jpg/03/31/69/91/1000_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg'}" alt="${post.author.username}">
                    <strong>${post.author.username}</strong>
                </div>

                <img src="/api/images/image/${post.id}" alt="${post.image}" class="post-image">

                <div class="post-actions">
                    <i class="far fa-heart"></i>
                    <i class="far fa-comment ms-3"></i>
                </div>

                <div class="post-stats">
                    <strong>${post.likesCount} likes</strong>
                </div>

                <div class="post-description">
                    <strong>${post.author.username}</strong> ${post.description}
                </div>

                <div class="post-stats">
                    View all ${post.commentsCount} comments
                </div>

                <div class="post-time">
                    ${post.createdAt?string("yyyy-MM-dd")}
                </div>
            </div>
        </#list>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>