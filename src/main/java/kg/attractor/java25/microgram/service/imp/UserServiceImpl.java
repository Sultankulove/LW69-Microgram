package kg.attractor.java25.microgram.service.imp;

import kg.attractor.java25.microgram.dto.UserDto;
import kg.attractor.java25.microgram.dto.UserProfileDto;
import kg.attractor.java25.microgram.dto.UserRegisterDto;
import kg.attractor.java25.microgram.dto.UserUpdateDto;
import kg.attractor.java25.microgram.dto.image.PostDto;
import kg.attractor.java25.microgram.model.Post;
import kg.attractor.java25.microgram.repository.FollowRepository;
import kg.attractor.java25.microgram.repository.PostRepository;
import kg.attractor.java25.microgram.service.FollowService;
import kg.attractor.java25.microgram.exceptions.NotFoundException;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import kg.attractor.java25.microgram.mapper.UserMapper;
import kg.attractor.java25.microgram.model.User;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import kg.attractor.java25.microgram.repository.UserRepository;
import kg.attractor.java25.microgram.service.UserService;

import java.util.List;

@Service
@AllArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {
    private UserRepository userRepository;
    private PasswordEncoder passwordEncoder;
    private FollowService followService;
    private PostRepository postRepository;
    private FollowRepository followRepository;


    @Override
    public List<UserDto> searchUsers(String raw) {
        String mode;
        String text = raw.trim();

        if (text.startsWith("@")) {
            mode = "EMAIL";
            text = text.substring(1);
        } else if (text.startsWith("#")) {
            mode = "USERNAME";
            text = text.substring(1);
        } else if (text.toUpperCase().startsWith("ID")) {
            mode = "ID";
            text = text.substring(2);
        } else {
            mode = "GENERAL";
        }

        return userRepository.searchUsers(mode, text)
                .stream()
                .map(UserMapper::fromDto)
                .toList();
    }

    @Override
    public User register(UserRegisterDto register) {
        if (userRepository.findByEmail(register.getEmail()).isPresent()) {
            throw new UsernameNotFoundException("Пользователь с таким email уже занят");
        }
        User user = UserMapper.userRegister(register);
        user.setPassword(passwordEncoder.encode(register.getPassword()));
        user.setRole(user.getRole());
        user.setEnabled(true);
        User savedUser = userRepository.save(user);
        log.info("Пользователь {} успешно зарегистрировался с id={}", savedUser.getEmail(), savedUser.getId());
        return savedUser;
    }

    @Override
    public User getById(Long id) {
        log.info("Получение пользователя по id={}", id);
        return userRepository.findById(id)
                .orElseThrow(() -> {
                    log.warn("Пользователь с id={} не найден", id);
                    return new RuntimeException("User not found");
                });
    }

    @Override
    public List<User> search(String keyword) {
        log.info("Поиск пользователей по ключевому слову: {}", keyword);
        return userRepository.findByNameContainingIgnoreCaseOrDisplayNameContainingIgnoreCaseOrEmailContainingIgnoreCase(keyword, keyword, keyword);
    }

    @Override
    public void follow(Long followerId, Long followingId) {
        log.info("Пользователь {} подписывается на {}", followerId, followingId);
        User follower = getById(followerId);
        User following = getById(followingId);
        followService.follow(follower, following);
    }

    @Override
    public void unfollow(Long followerId, Long followingId) {
        log.info("Пользователь {} отписывается от {}", followerId, followingId);
        User follower = getById(followerId);
        User following = getById(followingId);
        followService.unfollow(follower, following);
    }

    @Override
    public void follow(Long followingId, Authentication auth) {
        User follower = findByEmail(auth.getName());
        follow(follower.getId(), followingId);
    }

    @Override
    public Long findUserIdByEmail(String email) {
        return userRepository.findUserIdByEmailIgnoreCase(email)
                .orElseThrow(() -> new NotFoundException("Email: " + email));

    }

    @Override
    public User getUserById(Long id) {
        return userRepository.getUserById(id);
    }
    @Override
    public void unfollow(Long followingId, Authentication auth) {
        User follower = findByEmail(auth.getName());
        unfollow(follower.getId(), followingId);
    }


    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found with email: " + email));
    }


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        var user = userRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
        return new org.springframework.security.core.userdetails.User(
                user.getEmail(),
                user.getPassword(),
                user.getAuthorities()
        );
    }
    @Override
    public int getPostsCount(User user) {
        return user.getPosts() != null ? user.getPosts().size() : 0;
    }

    @Override
    public int getFollowersCount(User user) {
        return followService.countFollowers(user);
    }

    @Override
    public int getFollowingCount(User user) {
        return followService.countFollowing(user);
    }

    @Override
    public boolean isFollowing(User follower, User following) {
        return followService.isFollowing(follower, following);
    }

    @Override
    public UserProfileDto getUserProfileByUserId(Long id) {
        User user = userRepository.getUserById(id);
        UserProfileDto userProfileDto = new UserProfileDto();
        userProfileDto.setId(user.getId());
        userProfileDto.setUsername(user.getName());
        userProfileDto.setDisplayName(user.getDisplayName());
        userProfileDto.setEmail(user.getEmail());
        userProfileDto.setBio(user.getBio());
        userProfileDto.setAvatar(user.getAvatar());

        userProfileDto.setPostsCount(user.getPostsCount());
        userProfileDto.setFollowersCount(followService.countFollowers(user));
        userProfileDto.setFollowingCount(followService.countFollowing(user));

        userProfileDto.setPosts(getMyPosts(id));
        return userProfileDto;
    }

    private List<PostDto> getMyPosts(Long id) {

        List<Post> posts = postRepository.findPostByAuthor_Id(id);
        return posts.stream()
                .map(post -> PostDto.builder()
                        .id(post.getId())
                        .author(UserMapper.fromDto(post.getAuthor()))
                        .description(post.getDescription())
                        .image(post.getImage())
                        .createdAt(post.getCreatedAt())
                        .commentsCount(post.getCommentsCount())
                        .likesCount(post.getLikesCount())
                        .build())
                .toList();    }



    @Override
    public void updateUser(UserUpdateDto dto, Authentication authentication) {
        String email = authentication.getName();

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new NotFoundException("Пользователь с таким email не найден"));

        user.setName(dto.getName());
        user.setDisplayName(dto.getDisplayName());
        user.setAvatar(dto.getAvatar());
        user.setBio(dto.getBio());
        userRepository.save(user);
    }


}
