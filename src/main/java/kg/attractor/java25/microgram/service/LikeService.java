package kg.attractor.java25.microgram.service;

import org.springframework.transaction.annotation.Transactional;

public interface LikeService {
    @Transactional
    boolean like(Long postId, Long userId);

    @Transactional
    void unlike(Long postId, Long userId);
}
