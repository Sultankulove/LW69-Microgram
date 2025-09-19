package kg.attractor.java25.microgram.service;

import kg.attractor.java25.microgram.dto.image.PostDto;
import kg.attractor.java25.microgram.dto.image.PostUpsertDto;
import kg.attractor.java25.microgram.model.Post;
import kg.attractor.java25.microgram.model.User;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface PostService {

    @Transactional
    Long createPost(PostUpsertDto dto, MultipartFile image);

    List<PostDto> getRandomPosts(Long userId);

    List<PostDto> getMyPosts(Long id);

}
