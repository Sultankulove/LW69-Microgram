package kg.attractor.java25.microgram.service;

import kg.attractor.java25.microgram.dto.UserProfileDto;
import kg.attractor.java25.microgram.dto.UserRegisterDto;
import kg.attractor.java25.microgram.model.User;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {
    User register (UserRegisterDto register);

    Long findUserIdByEmail(String name);

    User getUserById(Long authorId);

    User getById(Long id);
    List<User> search(String keyword);
    void follow(Long followerId, Long followingId);
    void unfollow(Long followerId, Long followingId);
    void follow(Long followingId, Authentication auth);
    void unfollow(Long followingId, Authentication auth);


    User findByEmail(String email);


    int getPostsCount(User user);
    int getFollowersCount(User user);
    int getFollowingCount(User user);
    boolean isFollowing(User follower, User following);

    UserProfileDto getUserProfileByUserId(Long id);
}
