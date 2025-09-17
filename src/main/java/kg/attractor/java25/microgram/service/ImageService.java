package kg.attractor.java25.microgram.service;

import kg.attractor.java25.microgram.dto.image.AvatarDto;
import kg.attractor.java25.microgram.dto.image.ImageDto;
import org.springframework.http.ResponseEntity;

public interface ImageService {
    void uploadAvatar(AvatarDto dto);

    ResponseEntity<?> getAvatarById(Long userId);

    void uploadImage(ImageDto build);

    ResponseEntity<?> downloadImageByPostId(Long postId);
}
