package kg.attractor.java25.microgram.dto;

import kg.attractor.java25.microgram.dto.image.PostDto;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class UserProfileDto {
    private Long id;
    private String username;
    private String displayName;
    private String email;
    private String bio;
    private String avatar;

    private Integer postsCount;
    private Integer followersCount;
    private Integer followingCount;

    private List<PostDto> posts;

    private boolean following;
}
