package kg.attractor.java25.microgram.repository;

import kg.attractor.java25.microgram.model.Follow;
import kg.attractor.java25.microgram.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface FollowRepository extends JpaRepository<Follow, Long> {


    Optional<Follow> findByFollowerAndFollowing(User follower, User following);

    List<Follow> findByFollower(User follower);

    List<Follow> findByFollowing(User following);

    int countByFollower(User follower);
    int countByFollowing(User user);


    boolean existsByFollowerAndFollowing(User currentUser, User author);
}
