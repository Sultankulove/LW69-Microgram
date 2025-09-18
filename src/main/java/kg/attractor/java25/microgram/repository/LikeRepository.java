package kg.attractor.java25.microgram.repository;

import kg.attractor.java25.microgram.model.Like;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.Set;

public interface LikeRepository extends JpaRepository<Like, Long> {
    boolean existsByPostIdAndUserId(Long postId, Long userId);

    void deleteLikeByUser_IdAndPost_Id(Long userId, Long postId);

    @Query("select l.post.id from Like l where l.user.id = :userId and l.post.id in :postIds")
    Set<Long> findLikedPostIds(@Param("userId") Long userId, @Param("postIds") Collection<Long> postIds);

    void deleteByPostIdAndUserId(Long postId, Long userId);
}

