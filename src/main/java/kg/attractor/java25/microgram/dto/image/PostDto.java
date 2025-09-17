package kg.attractor.java25.microgram.dto.image;

import kg.attractor.java25.microgram.model.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PostDto {
    private User author;
    private String image;
    private String description;
    private int likesCount;
    private int commentsCount;
    private Timestamp createdAt;
}
