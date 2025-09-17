package service;

import dto.UserRegisterDto;
import midel.User;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface UserService extends UserDetailsService {
    User register (UserRegisterDto register);

}
