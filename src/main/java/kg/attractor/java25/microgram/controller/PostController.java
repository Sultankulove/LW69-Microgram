package kg.attractor.java25.microgram.controller;

import kg.attractor.java25.microgram.dto.image.PostUpsertDto;
import kg.attractor.java25.microgram.service.PostService;
import kg.attractor.java25.microgram.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequiredArgsConstructor
public class PostController {
    private final UserService userService;
    private final PostService postService;

    @GetMapping("/post")
    public String postForm(Model model, Authentication authentication) {
        PostUpsertDto dto = new PostUpsertDto();
        dto.setAuthorId(userService.findUserIdByEmail(authentication.getName()));
        model.addAttribute("post", dto);
        return "post";
    }


    @PostMapping(value = "/post", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String createPost(@ModelAttribute("post") PostUpsertDto dto,
                             @RequestParam("image") MultipartFile image,
                             Authentication authentication,
                             Model model) {

        if (dto.getAuthorId() == null) {
            dto.setAuthorId(userService.findUserIdByEmail(authentication.getName()));
        }

        Long postId = postService.createPost(dto, image);
        model.addAttribute("postId", postId);
        model.addAttribute("post", dto);
        return "post";
    }
}
