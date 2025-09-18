package kg.attractor.java25.microgram.controller.api;

import kg.attractor.java25.microgram.dto.CommentDto;
import kg.attractor.java25.microgram.service.CommentService;
import kg.attractor.java25.microgram.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/comments")
public class CommentApiController {
    private final CommentService commentService;
    private final UserService userService;

    @GetMapping("/{postId}")
    public List<CommentDto> list(@PathVariable Long postId, Authentication auth) {
        Long meId = auth != null ? userService.findUserIdByEmail(auth.getName()) : null;
        return commentService.list(postId, meId);
    }

    @PostMapping("/{postId}")
    public CommentDto add(@PathVariable Long postId,
                          @RequestBody Map<String, String> body,
                          Authentication auth) {
        Long meId = userService.findUserIdByEmail(auth.getName());
        return commentService.add(postId, meId, body.get("text"));
    }

    @DeleteMapping("/{commentId}")
    public ResponseEntity<?> delete(@PathVariable Long commentId, Authentication auth) {
        Long meId = userService.findUserIdByEmail(auth.getName());
        commentService.delete(commentId, meId);
        return ResponseEntity.noContent().build();
    }
}
