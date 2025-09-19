package kg.attractor.java25.microgram.repository;

import kg.attractor.java25.microgram.model.Post;
import kg.attractor.java25.microgram.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PostRepository extends JpaRepository<Post, Long> {

    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query("update Post p set p.image = :fileName where p.id = :postId")
    int savePostImage(@Param("fileName") String fileName,
                      @Param("postId") Long postId);

    @Query("select p.image from Post p where p.id = :id")
    Optional<String> getImageById(@Param("id") Long id);

    List<Post> findPostByAuthor_Id(Long authorId);


    Optional<Post> findByIdAndAuthorId(Long id, Long authorId);

    @Modifying
    @Query("delete from Post p where p.id = :id and p.author.id = :authorId")
    int deleteByIdAndAuthorId(@Param("id") Long id, @Param("authorId") Long authorId);


}
