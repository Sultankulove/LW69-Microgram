package kg.attractor.java25.microgram.repository;

import kg.attractor.java25.microgram.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);



    List<User> findByNameContainingIgnoreCaseOrDisplayNameContainingIgnoreCaseOrEmailContainingIgnoreCase(String keyword, String keyword1, String keyword2);
}
