package kg.attractor.java25.microgram.repository;

import kg.attractor.java25.microgram.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentRepository extends JpaRepository<Comment, Long> {
}
