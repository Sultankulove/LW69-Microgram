package kg.attractor.java25.microgram.dto.image;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PostUpsertDto {
    private Long authorId;

    @NotBlank(message = "Описание обязательно")
    private String description;
}
