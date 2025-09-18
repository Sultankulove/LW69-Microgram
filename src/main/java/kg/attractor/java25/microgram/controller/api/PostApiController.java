package kg.attractor.java25.microgram.controller.api;

import kg.attractor.java25.microgram.service.LikeService;
import kg.attractor.java25.microgram.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class PostApiController {
    private final LikeService likeService;
    private final UserService userService;

    @PostMapping("/likes/{postId}")
    public ResponseEntity<?> like(@PathVariable Long postId, Authentication auth) {
        if (auth == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        boolean created = likeService.like(postId, userService.findUserIdByEmail(auth.getName()));
        return created ? ResponseEntity.ok().build()
                : ResponseEntity.status(HttpStatus.CONFLICT).build();
    }


    @DeleteMapping("/likes/{postId}")
    public ResponseEntity<Void> unlike(
            @PathVariable Long postId,
            Authentication auth) {
        likeService.unlike(
                postId,
                userService.findUserIdByEmail(
                        auth.getName()
                )
        );
        return ResponseEntity.noContent().build();
    }
}
