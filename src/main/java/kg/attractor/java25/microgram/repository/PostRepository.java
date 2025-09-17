package kg.attractor.java25.microgram.repository;

import kg.attractor.java25.microgram.model.Post;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.http.ResponseEntity;

public interface PostRepository extends JpaRepository<Post, Long> {

    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query("update Post p set p.image = :fileName where p.id = :postId")
    int savePostImage(@Param("fileName") String fileName,
                      @Param("postId") Long postId);

    ResponseEntity<?> getImageById(Long id);
}
