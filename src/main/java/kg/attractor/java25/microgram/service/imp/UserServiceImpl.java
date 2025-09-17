package kg.attractor.java25.microgram.service.imp;

import kg.attractor.java25.microgram.dto.UserRegisterDto;
import kg.attractor.java25.microgram.repository.FollowRepository;
import kg.attractor.java25.microgram.service.FollowService;
import kg.attractor.java25.microgram.exceptions.NotFoundException;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import kg.attractor.java25.microgram.mapper.UserMapper;
import kg.attractor.java25.microgram.model.User;

import org.springframework.security.core.Authentication;
import org.springframework.data.crossstore.ChangeSetPersister;
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
    private FollowRepository followRepository;

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
}
