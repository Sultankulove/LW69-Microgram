package kg.attractor.java25.microgram.repository;

import kg.attractor.java25.microgram.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);

    @Query("select u.id from User u where lower(u.email) = lower(:email)")
    Optional<Long> findUserIdByEmailIgnoreCase(@Param("email") String email);

    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Transactional
    @Query("update User u set u.avatar = :avatar where u.id = :id")
    int saveAvatar(@Param("avatar") String avatar, @Param("id") Long id);

    @Query("select u.avatar from User u where u.id = :id")
    Optional<String> getAvatarById(@Param("id") Long id);

    User getUserById(Long id);

    List<User> findByNameContainingIgnoreCaseOrDisplayNameContainingIgnoreCaseOrEmailContainingIgnoreCase(String keyword, String keyword1, String keyword2);
}
