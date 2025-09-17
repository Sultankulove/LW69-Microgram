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

        @Column(name = "username")
        private String name;
        private String email;
        private String password;
        private String role;
        private String bio;
        private String avatar;
        private boolean enabled;
@Getter
@Setter
@Entity
@Table(name = "users")
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String username;
    private String email;
    private String password;
    private String role;
    private String bio;
    private String avatar;
    private boolean enabled;

        @Column(name = "display_name")
        private String displayName;

        @Column(name = "posts_count")
        private Integer postsCount;

        @Column(name = "followers_count")
        private Integer followersCount;

        @Column(name = "following_count")
        private Integer followingCount;

        @OneToMany(mappedBy = "authorId", cascade = CascadeType.ALL)
        private List<Post> posts;

        @OneToMany(mappedBy = "userId", cascade = CascadeType.ALL)
        private List<Like> likes;

        @OneToMany(mappedBy = "authorId", cascade = CascadeType.ALL)
        private List<Comment> comments;

        @OneToMany(mappedBy = "followerId", cascade = CascadeType.ALL)
        private List<Follow> following;

        @OneToMany(mappedBy = "followingId")
        private List<Follow> followers;

        @Override
        public Collection<? extends GrantedAuthority> getAuthorities() {
            return List.of(new SimpleGrantedAuthority("ROLE_USER"));
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
