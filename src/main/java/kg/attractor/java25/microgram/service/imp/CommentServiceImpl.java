package kg.attractor.java25.microgram.service.imp;

import kg.attractor.java25.microgram.dto.CommentDto;
import kg.attractor.java25.microgram.model.Comment;
import kg.attractor.java25.microgram.model.Post;
import kg.attractor.java25.microgram.model.User;
import kg.attractor.java25.microgram.repository.CommentRepository;
import kg.attractor.java25.microgram.repository.PostRepository;
import kg.attractor.java25.microgram.repository.UserRepository;
import kg.attractor.java25.microgram.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {
    private final CommentRepository commentRepo;
    private final PostRepository postRepo;
    private final UserRepository userRepo;

    @Transactional(readOnly = true)
    @Override
    public List<CommentDto> list(Long postId, Long meId) {
        return commentRepo.findByPostIdOrderByCreatedAtDesc(postId)
                .stream()
                .map(c -> CommentDto.builder()
                        .id(c.getId())
                        .postId(postId)
                        .authorId(c.getAuthor().getId())
                        .authorUsername(c.getAuthor().getUsername())
                        .text(c.getText())
                        .createdAt(c.getCreatedAt())
                        .mine(meId != null && meId.equals(c.getAuthor().getId()))
                        .build())
                .toList();
    }

    @Transactional
    @Override
    public CommentDto add(Long postId, Long meId, String text) {
        Post post = postRepo.findById(postId).orElseThrow();
        User me = userRepo.findById(meId).orElseThrow();

        Comment c = new Comment();
        c.setPost(post);
        c.setAuthor(me);
        c.setText(text == null ? "" : text.trim());
        if (c.getText().isBlank()) throw new IllegalArgumentException("Пустой комментарий");

        Comment saved = commentRepo.save(c);

        post.setCommentsCount(post.getCommentsCount() + 1);

        return CommentDto.builder()
                .id(saved.getId())
                .postId(postId)
                .authorId(meId)
                .authorUsername(me.getUsername())
                .text(saved.getText())
                .createdAt(saved.getCreatedAt())
                .mine(true)
                .build();
    }

    @Transactional
    @Override
    public void delete(Long commentId, Long meId) {
        var c = commentRepo.findById(commentId).orElseThrow();
        if (!c.getAuthor().getId().equals(meId)) {
            throw new SecurityException("Можно удалять только свои комментарии");
        }
        Post post = c.getPost();
        commentRepo.delete(c);
        post.setCommentsCount(Math.max(0, post.getCommentsCount() - 1));
    }
}
