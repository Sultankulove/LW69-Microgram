package kg.attractor.java25.microgram.service.imp;

import kg.attractor.java25.microgram.dto.image.PostUpsertDto;
import kg.attractor.java25.microgram.model.Post;
import kg.attractor.java25.microgram.repository.PostRepository;
import kg.attractor.java25.microgram.service.PostService;
import kg.attractor.java25.microgram.service.UserService;
import kg.attractor.java25.microgram.util.FileUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

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
}
