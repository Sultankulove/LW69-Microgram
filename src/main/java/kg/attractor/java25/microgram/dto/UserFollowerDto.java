package kg.attractor.java25.microgram.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class UserFollowerDto {
    private Long id;
    private String name;
    private String displayName;
    private String avatar;
}
