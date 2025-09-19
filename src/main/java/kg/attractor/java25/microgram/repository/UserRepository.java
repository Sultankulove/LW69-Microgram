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


    @Query("""
            SELECT u FROM User u
            WHERE
              (:mode = 'EMAIL' AND LOWER(u.email) LIKE LOWER(CONCAT('%', :text, '%')))
              OR (:mode = 'USERNAME' AND LOWER(u.name) LIKE LOWER(CONCAT('%', :text, '%')))
              OR (:mode = 'ID' AND CAST(u.id AS string) LIKE CONCAT('%', :text, '%'))
              OR (:mode = 'GENERAL' AND (
                    LOWER(u.displayName) LIKE LOWER(CONCAT('%', :text, '%')) OR
                    LOWER(u.name) LIKE LOWER(CONCAT('%', :text, '%')) OR
                    LOWER(u.email) LIKE LOWER(CONCAT('%', :text, '%'))
                 ))
            """)
    List<User> searchUsers(@Param("mode") String mode, @Param("text") String text);
}
