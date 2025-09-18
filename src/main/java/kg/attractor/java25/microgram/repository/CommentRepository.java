package kg.attractor.java25.microgram.repository;

import kg.attractor.java25.microgram.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    List<Comment> findByPostIdOrderByCreatedAtDesc(Long postId);
    Optional<Comment> findByIdAndAuthorId(Long id, Long authorId);
}
