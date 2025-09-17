package dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserRequestDto {
    private String username;
    private String email;
    private String password;
    private String displayName;
    private String bio;
    private String avatar;
}
