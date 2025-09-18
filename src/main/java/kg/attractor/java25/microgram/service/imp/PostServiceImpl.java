package kg.attractor.java25.microgram.service.imp;

import kg.attractor.java25.microgram.dto.image.PostDto;
import kg.attractor.java25.microgram.dto.image.PostUpsertDto;
import kg.attractor.java25.microgram.mapper.UserMapper;
import kg.attractor.java25.microgram.model.Post;
import kg.attractor.java25.microgram.repository.PostRepository;
import kg.attractor.java25.microgram.service.PostService;
import kg.attractor.java25.microgram.service.UserService;
import kg.attractor.java25.microgram.util.FileUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {
    private final PostRepository postRepository;
    private final UserService userService;


    @Transactional
    @Override
    public Long createPost(PostUpsertDto dto, MultipartFile image) {
        if (image == null || image.isEmpty()) {
            throw new IllegalArgumentException("Image is required");
        }

        String imagePath = FileUtil.saveUploadedFile(image, "image");
        Post post = new Post();
        post.setAuthor(userService.getUserById(dto.getAuthorId()));
        post.setDescription(dto.getDescription());
        post.setImage(imagePath);
        Post saved = postRepository.save(post);


        return saved.getId();
    }

    @Override
    public List<PostDto> getRandomPosts() {
        List<Post> posts = postRepository.findAll();
        Collections.shuffle(posts);

        return posts.stream()
                .map(post -> PostDto.builder()
                        .id(post.getId())
                        .author(UserMapper.fromDto(post.getAuthor()))
                        .description(post.getDescription())
                        .image(post.getImage())
                        .createdAt(post.getCreatedAt())
                        .commentsCount(post.getCommentsCount())
                        .likesCount(post.getLikesCount())
                        .build())
                .limit(10)
                .toList();
    }

    @Override
    public List<PostDto> getMyPosts(Long id) {

        List<Post> posts = postRepository.findPostByAuthor_Id(id);
        return posts.stream()
                .map(post -> PostDto.builder()
                        .id(post.getId())
                        .author(UserMapper.fromDto(post.getAuthor()))
                        .description(post.getDescription())
                        .image(post.getImage())
                        .createdAt(post.getCreatedAt())
                        .commentsCount(post.getCommentsCount())
                        .likesCount(post.getLikesCount())
                        .build())
                .limit(10)
                .toList();    }
}
