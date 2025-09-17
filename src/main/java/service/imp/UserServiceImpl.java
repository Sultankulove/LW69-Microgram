package service.imp;

import dto.UserRegisterDto;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mapper.UserMapper;
import midel.User;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import repository.UserRepository;
import service.UserService;

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
