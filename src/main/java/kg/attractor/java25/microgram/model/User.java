package kg.attractor.java25.microgram.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "users")
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "username", nullable = false, length = 50, unique = true)
    private String name;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "role")
    private String role;

    @Column(name = "bio")
    private String bio;

    @Column(name = "avatar")
    private String avatar;

    @Column(name = "enabled")
    private boolean enabled;

    @Column(name = "display_name")
    private String displayName;

    @Column(name = "posts_count")
    private Integer postsCount;

    @Column(name = "followers_count")
    private Integer followersCount;

    @Column(name = "following_count")
    private Integer followingCount;

    @OneToMany(mappedBy = "author", cascade = CascadeType.ALL)
    private List<Post> posts;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Like> likes;

    @OneToMany(mappedBy = "author", cascade = CascadeType.ALL)
    private List<Comment> comments;

    @OneToMany(mappedBy = "followerId", cascade = CascadeType.ALL)
    private List<Follow> following;

    @OneToMany(mappedBy = "followingId")
    private List<Follow> followers;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        String r = (role == null || role.isBlank()) ? "ROLE_USER"
                : (role.startsWith("ROLE_") ? role : "ROLE_" + role);
        return List.of(new SimpleGrantedAuthority(r));
    }


    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
    @Override
    public boolean isEnabled() {
        return enabled;
    }
}
