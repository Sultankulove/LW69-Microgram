package kg.attractor.java25.microgram.service.imp;

import kg.attractor.java25.microgram.dto.image.PostDto;
import kg.attractor.java25.microgram.dto.image.PostUpsertDto;
import kg.attractor.java25.microgram.mapper.UserMapper;
import kg.attractor.java25.microgram.model.Post;
import kg.attractor.java25.microgram.repository.FollowRepository;
import kg.attractor.java25.microgram.repository.LikeRepository;
import kg.attractor.java25.microgram.repository.PostRepository;
import kg.attractor.java25.microgram.repository.UserRepository;
import kg.attractor.java25.microgram.service.PostService;
import kg.attractor.java25.microgram.service.UserService;
import kg.attractor.java25.microgram.util.FileUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.util.Collections;
import java.util.List;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {
    private final PostRepository postRepository;
    private final UserService userService;
    private final LikeRepository likeRepository;

    private  final FollowRepository followRepository;

    private final UserRepository userRepository;



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

    @Transactional
    @Override
    public void deletePost(Long postId, String authorEmail) {
        var post = postRepository.findById(postId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Post not found"));
        var me = userRepository.findByEmail(authorEmail)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED));

        if (!post.getAuthor().getId().equals(me.getId())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Not your post");
        }

        postRepository.delete(post);
        me.setPostsCount(Math.max(0, me.getPostsCount() - 1));
        userRepository.save(me);

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
                .toList();
    }

    @Override
    public List<PostDto> getMyFollowingRandomPosts(Long id) {
        List<Post> posts = postRepository.findAll();
        Collections.shuffle(posts);

        Set<Long> likedIds = likeRepository.findLikedPostIds(
                id,
                posts.stream().map(Post::getId).toList()
        );

        return posts.stream()
                .map(post -> PostDto.builder()
                        .id(post.getId())
                        .author(UserMapper.fromDto(post.getAuthor()))
                        .description(post.getDescription())
                        .image(post.getImage())
                        .createdAt(post.getCreatedAt())
                        .commentsCount(post.getCommentsCount())
                        .likedByMe(likedIds.contains(post.getId()))
                        .likesCount(post.getLikesCount())
                        .build())
                .toList();
    }

    @Override
    public List<PostDto> getMyPosts(Long id) {

        List<Post> posts = postRepository.findPostByAuthor_Id(id);

        Set<Long> likedIds = likeRepository.findLikedPostIds(
                id,
                posts.stream().map(Post::getId).toList()
        );
        return posts.stream()
                .map(post -> PostDto.builder()
                        .id(post.getId())
                        .author(UserMapper.fromDto(post.getAuthor()))
                        .description(post.getDescription())
                        .image(post.getImage())
                        .createdAt(post.getCreatedAt())
                        .commentsCount(post.getCommentsCount())
                        .likesCount(post.getLikesCount())
                        .likedByMe(likedIds.contains(post.getId()))
                        .build())
                .limit(10)
                .toList();
    }





}
