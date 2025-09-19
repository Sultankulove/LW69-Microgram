package kg.attractor.java25.microgram.controller.api;

import kg.attractor.java25.microgram.dto.image.AvatarDto;
import kg.attractor.java25.microgram.dto.image.ImageDto;
import kg.attractor.java25.microgram.service.ImageService;
import kg.attractor.java25.microgram.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/images")
public class ImageApiController {
    private final ImageService imageService;
    private final UserService userService;

    @GetMapping("/defaultAvatar")
    public ResponseEntity<?> downloadDefaultAvatar() {
        return imageService.getDefaultAvatar();
    }

//    @GetMapping("/avatar")



    @PostMapping("/image")
    public ResponseEntity<Void> uploadImage(
            @RequestPart("image") MultipartFile image,
            @RequestPart("postId") Long postId) {
        imageService.uploadImage(
                ImageDto
                        .builder()
                        .postId(postId)
                        .image(image)
                        .build()
        );
        return ResponseEntity.noContent().build();
    }


    @GetMapping("/image")
    public ResponseEntity<?> downloadImage(Long postId) {
        return imageService.downloadImageByPostId(postId);
    }

    @GetMapping("image/{id}")
    public ResponseEntity<?> downloadImageById(@PathVariable Long id) {
        return imageService.downloadImageByPostId(id);
    }

    @GetMapping("/avatar/{id}")
    public ResponseEntity<?> downloadAvatarById(@PathVariable Long id) {
        return imageService.getAvatarById(id);
    }

    @PostMapping("/avatar")
    public ResponseEntity<Void> uploadAvatar(
            @RequestPart("avatar") MultipartFile avatar,
            Principal principal) {
        imageService.uploadAvatar(
                AvatarDto
                        .builder()
                        .userId(
                                userService.findUserIdByEmail(principal.getName())
                        )
                        .avatar(avatar)
                        .build()
        );

        return ResponseEntity.noContent().build();
    }

    @GetMapping("/avatar")
    public ResponseEntity<?> downloadAvatar(Authentication authentication) {
        return imageService.getAvatarById(
                userService.findUserIdByEmail(authentication.getName())
        );
    }



}
