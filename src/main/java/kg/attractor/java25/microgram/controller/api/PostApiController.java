package kg.attractor.java25.microgram.controller.api;

import kg.attractor.java25.microgram.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;
import java.util.Map;

@RestController
@RequestMapping("/api/posts")
@RequiredArgsConstructor
public class PostApiController {
    private final PostService postService;

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<Map<String, Long>> create(
            @RequestPart("image") MultipartFile image,
            @RequestPart(value = "description", required = false) String description,
            Principal principal) {

        Long id = postService.createPostWithImage(image, description, principal.getName());
        return ResponseEntity.status(HttpStatus.CREATED).body(Map.of("id", id));
    }
}
