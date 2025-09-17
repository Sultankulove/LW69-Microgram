package kg.attractor.java25.microgram.repository;

import kg.attractor.java25.microgram.model.Follow;
import kg.attractor.java25.microgram.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface FollowRepository extends JpaRepository<Follow, Long> {
    Optional<Follow> findFollowersIdAndFollowingId(User followers, User following);



    Optional<Follow> findFollowerIdAndFollowingId(User follower, User following);

    void findByFollowerIdAndFollowingId(User follower, User following);

    List<Follow> findByFollowingId(User user);

    List<Follow> findByFollowerId(User user);
}
