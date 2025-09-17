package kg.attractor.java25.microgram.dto.image;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ImageDto {
    @NotNull(message = "Фото обязательно!")
    private MultipartFile image;

    private Long postId;
}
