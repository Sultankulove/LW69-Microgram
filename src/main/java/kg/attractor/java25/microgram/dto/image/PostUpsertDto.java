package kg.attractor.java25.microgram.dto.image;

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
    private String image;
    private String description;
}
