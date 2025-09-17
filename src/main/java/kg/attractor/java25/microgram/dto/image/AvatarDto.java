package kg.attractor.java25.microgram.dto.image;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AvatarDto {
    @NotNull(message = "Аватар обязателен")
    private MultipartFile avatar;

    private Long userId;
}
