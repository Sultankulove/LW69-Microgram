package kg.attractor.java25.microgram.service.imp;

import kg.attractor.java25.microgram.model.Follow;
import kg.attractor.java25.microgram.model.User;
import kg.attractor.java25.microgram.repository.FollowRepository;
import kg.attractor.java25.microgram.service.FollowService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class FollowingServiceImp implements FollowService {
    private final FollowRepository followRepository;
    @Override
    public Follow follow(User follower, User following) {
        log.info("Пользователь {} подписывается на {}", follower.getId(), following.getId());
        if (follower.getId().equals(following.getId())) {
            log.warn("Попытка подписаться на себя: {}", follower.getId());
            throw new IllegalArgumentException("Нельзя подписаться на самого себя");
        }
        Optional<Follow> existing = followRepository.findFollowerIdAndFollowingId(follower,following);
        if (existing.isPresent()) {
            log.warn("Подписка уже существует: {} -> {}", follower.getId(), following.getId());
            return existing.get();
        }
        Follow follow = new Follow();
        follow.setFollowerId(follower);
        follow.setFollowingId(following);
        follow.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));
        return followRepository.save(follow);
    }

    @Override
    public void unfollow(User follower, User following) {
        log.info("Пользователь {} отписывается от {}", follower.getId(), following.getId());
        followRepository.findByFollowerIdAndFollowingId(follower, following);

    }

    @Override
    public List<Follow> getFollowing(User user) {
        log.info("Получаем список подписок пользователя {}", user.getId());
        return followRepository.findByFollowerId(user);
    }

    @Override
    public List<Follow> getFollower(User user) {
        log.info("Получаем список подписчиков пользователя {}", user.getId());
        return followRepository.findByFollowingId(user);
    }
}
