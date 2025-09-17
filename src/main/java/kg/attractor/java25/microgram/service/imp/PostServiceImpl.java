package kg.attractor.java25.microgram.service.imp;

import kg.attractor.java25.microgram.dto.image.PostDto;
import kg.attractor.java25.microgram.dto.image.PostUpsertDto;
import kg.attractor.java25.microgram.model.Post;
import kg.attractor.java25.microgram.repository.PostRepository;
import kg.attractor.java25.microgram.service.ImageService;
import kg.attractor.java25.microgram.service.PostService;
import kg.attractor.java25.microgram.service.UserService;
import kg.attractor.java25.microgram.util.FileUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {
    private final PostRepository postRepository;
    private final UserService userService;
    private final ImageService imageService;

    @Override
    public void createPost(PostUpsertDto dto) {

        Post post = new Post();
        post.setAuthor(userService.getUserById(dto.getAuthorId()));
        post.setImage(dto.getImage());
        post.setDescription(dto.getDescription());

        postRepository.save(post);
    }

    @Override
    public Long createPostWithImage(MultipartFile image, String description, String name) {
        return 0L;
    }
//
//    @Transactional
//    @Override
//    public PostDto createPostWithImage(PostUpsertDto dto, MultipartFile image) {
//        if (image == null || image.isEmpty()) {
//            throw new IllegalArgumentException("Изображение обязательно");
//        }
//
//        String fileName = FileUtil.saveImage(image);
//
//        Post post = new Post();
//        post.setAuthor(dto.getAuthorId());
//        post.setDescription(dto.description());
//        post.setCreatedAt(LocalDateTime.now());
//        post.setCommentsCount(0);
//        post.setLikesCount(0);
//        post.setImage(fileName);
//
//        postRepository.save(post);
//
//        return PostDto.from(post);
//    }
}
