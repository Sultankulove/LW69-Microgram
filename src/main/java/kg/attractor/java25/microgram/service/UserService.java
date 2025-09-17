package kg.attractor.java25.microgram.service;

import kg.attractor.java25.microgram.dto.UserRegisterDto;
import kg.attractor.java25.microgram.model.User;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface UserService extends UserDetailsService {
    User register (UserRegisterDto register);

}
