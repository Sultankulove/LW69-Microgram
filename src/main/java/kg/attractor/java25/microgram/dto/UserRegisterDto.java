package kg.attractor.java25.microgram.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserRegisterDto {
    @Email
    private String email;

    @NotBlank(message = "Пароль обязателен")
    private String password;
}
