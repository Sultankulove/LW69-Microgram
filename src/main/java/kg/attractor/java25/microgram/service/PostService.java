package kg.attractor.java25.microgram.service;

import kg.attractor.java25.microgram.dto.image.PostUpsertDto;
import org.springframework.web.multipart.MultipartFile;

public interface PostService {
    void createPost(PostUpsertDto dto);

    Long createPostWithImage(MultipartFile image, String description, String name);
}
