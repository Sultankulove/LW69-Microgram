package kg.attractor.java25.microgram.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserDto {
    private Long id;
    private String username;
    private String email;
    private String displayName;
    private String avatar;
    private String bio;
    private String role;
    private Integer postsCount;
    private Integer followersCount;
    private Integer followingCount;


}
