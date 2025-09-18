<#import "layout.ftlh" as index>
<@index.layout>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Post - Microgram</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fafafa;
            margin: 0;
            padding: 20px;
        }

        .post-container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border: 1px solid #dbdbdb;
            border-radius: 3px;
            padding: 20px;
        }

        .image-upload {
            border: 2px dashed #dbdbdb;
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
            cursor: pointer;
        }

        .image-preview {
            max-width: 100%;
            display: none;
            margin-bottom: 20px;
        }

        textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            border: 1px solid #dbdbdb;
            border-radius: 3px;
            resize: none;
            margin-bottom: 20px;
        }

        .submit-btn {
            background-color: #0095f6;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }

        .submit-btn:hover {
            background-color: #0081d6;
        }
    </style>
</head>

<form action="/post" method="post" enctype="multipart/form-data" class="post-container">
    <#if _csrf??>
        <input
                type="hidden"
                name="${(_csrf.parameterName)!'csrf-param-name'}"
                value="${(_csrf.token)!'csrf-token'}"/>

    </#if>
    <input type="hidden" name="authorId" value="${post.authorId?c}"/>

    <div class="image-upload" onclick="document.getElementById('file-input').click()">
        <p>Click to upload image</p>
        <input name="image" type="file" id="file-input" accept="image/*" style="display: none;" onchange="previewImage(event)">
    </div>
    <img name="image" id="preview" class="image-preview">
    <textarea name="description" placeholder="Write a caption..."></textarea>

        <button class="submit-btn">Share</button>
</form>

<script>
    function previewImage(event) {
        const preview = document.getElementById('preview');
        const file = event.target.files[0];
        const reader = new FileReader();

        reader.onload = function() {
            preview.src = reader.result;
            preview.style.display = 'block';
        }

        if (file) {
            reader.readAsDataURL(file);
        }
    }
</script>

</@index.layout>