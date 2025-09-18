package kg.attractor.java25.microgram.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserUpdateDto {
    private String name;
    private String bio;
    private String avatar;
    private String displayName;
}
