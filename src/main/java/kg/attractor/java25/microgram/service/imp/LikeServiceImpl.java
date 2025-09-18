package kg.attractor.java25.microgram.service.imp;

import kg.attractor.java25.microgram.model.Like;
import kg.attractor.java25.microgram.model.Post;
import kg.attractor.java25.microgram.model.User;
import kg.attractor.java25.microgram.repository.LikeRepository;
import kg.attractor.java25.microgram.repository.PostRepository;
import kg.attractor.java25.microgram.repository.UserRepository;
import kg.attractor.java25.microgram.service.LikeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class LikeServiceImpl implements LikeService {
    private final LikeRepository likeRepo;
    private final PostRepository postRepo;
    private final UserRepository userRepo;

    @Transactional
    @Override
    public boolean like(Long postId, Long userId) {
        if (likeRepo.existsByPostIdAndUserId(postId, userId)) {
            return false;
        }

        Post post = postRepo.findById(postId).orElseThrow();
        User user = userRepo.findById(userId).orElseThrow();

        Like like = new Like();
        like.setPost(post);
        like.setUser(user);
        likeRepo.save(like);

        post.setLikesCount(post.getLikesCount() + 1);
        postRepo.save(post);
        return true;
    }


    @Transactional
    @Override
    public void unlike(Long postId, Long userId) {
        if (!likeRepo.existsByPostIdAndUserId(postId, userId)) return;

        likeRepo.deleteByPostIdAndUserId(postId, userId);

        Post post = postRepo.getReferenceById(postId);
        post.setLikesCount(Math.max(0, post.getLikesCount() - 1));
    }
}
