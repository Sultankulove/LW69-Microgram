package kg.attractor.java25.microgram.service;

import kg.attractor.java25.microgram.dto.image.PostDto;
import kg.attractor.java25.microgram.dto.image.PostUpsertDto;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

public interface PostService {

    @Transactional
    Long createPost(PostUpsertDto dto, MultipartFile image);

    Long createPostWithImage(MultipartFile image, String description, String name);

}
