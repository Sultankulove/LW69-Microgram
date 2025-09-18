package kg.attractor.java25.microgram.service;

import kg.attractor.java25.microgram.dto.CommentDto;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface CommentService {
    @Transactional(readOnly = true)
    List<CommentDto> list(Long postId, Long meId);

    @Transactional
    CommentDto add(Long postId, Long meId, String text);

    @Transactional
    void delete(Long commentId, Long meId);
}
