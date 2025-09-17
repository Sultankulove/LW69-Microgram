package kg.attractor.java25.microgram.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserResponseDto {
    private Long id;
    private String username;
    private String email;
    private String displayName;
    private String bio;
    private String avatar;

    private Integer postsCount;
    private Integer followersCount;
    private Integer followingCount;
}
