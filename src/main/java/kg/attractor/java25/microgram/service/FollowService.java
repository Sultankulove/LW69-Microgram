package kg.attractor.java25.microgram.service;

import kg.attractor.java25.microgram.model.Follow;
import kg.attractor.java25.microgram.model.User;

import java.util.List;

public interface FollowService {
    Follow follow(User followers, User following);
    void unfollow(User followers, User following);
    List<Follow> getFollowing(User user);
    List<Follow>getFollower(User user);


    boolean isFollowing(User follower, User following);
    int countFollowers(User user);
    int countFollowing(User user);
}
