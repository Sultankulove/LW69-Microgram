package kg.attractor.java25.microgram.service.imp;

import kg.attractor.java25.microgram.dto.UserRegisterDto;
import kg.attractor.java25.microgram.exceptions.NotFoundException;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import kg.attractor.java25.microgram.mapper.UserMapper;
import kg.attractor.java25.microgram.model.User;

import org.springframework.data.crossstore.ChangeSetPersister;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import kg.attractor.java25.microgram.repository.UserRepository;
import kg.attractor.java25.microgram.service.UserService;

@Service
@AllArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {
    private UserRepository userRepository;
    private PasswordEncoder passwordEncoder;
    @Override
    public User register(UserRegisterDto register) {
       if (userRepository.findByEmail(register.getEmail()).isPresent()) {
           throw new UsernameNotFoundException("Пользователь с таким email уже занят");
       }
       User user = UserMapper.userRegister(register);
       user.setPassword(passwordEncoder.encode(register.getPassword()));
       user.setRole(user.getRole());
       user.setEnabled(true);
       return userRepository.save(user);
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
