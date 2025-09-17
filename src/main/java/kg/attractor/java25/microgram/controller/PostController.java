package kg.attractor.java25.microgram.controller;

import kg.attractor.java25.microgram.dto.image.PostUpsertDto;
import kg.attractor.java25.microgram.service.PostService;
import kg.attractor.java25.microgram.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class PostController {
    private final UserService userService;
    private final PostService postService;

    @GetMapping("/post")
    public String postForm(
            Model model,
            Authentication authentication) {
        PostUpsertDto dto = new PostUpsertDto();
        dto.setAuthorId(
                userService.findUserIdByEmail(
                        authentication.getName()
                )
        );

        model.addAttribute("post", dto);
        return "post";
    }

    @PostMapping("/post")
    public String createPost(
            PostUpsertDto dto,
            Model model) {

        postService.createPost(dto);
        model.addAttribute("post", dto);

        return "post";
    }
}
