package kg.attractor.java25.microgram.controller;


import kg.attractor.java25.microgram.service.PostService;
import kg.attractor.java25.microgram.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class MainController {
    private final PostService postService;
    private final UserService userService;
    @GetMapping
    public String index(Model model, Authentication auth) {
        if (auth != null && auth.isAuthenticated()) {
            var user = userService.findByEmail(auth.getName());
            model.addAttribute("posts", postService.getMyFollowingRandomPosts(user.getId()));
            model.addAttribute("userId", user.getId());
        } else {
            model.addAttribute("userId", -1);
            model.addAttribute("posts", postService.getRandomPosts());
        }

        return "index";
    }
}
