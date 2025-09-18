package kg.attractor.java25.microgram.dto;

import kg.attractor.java25.microgram.dto.image.PostDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PostsListViewDto {
    private List<PostDto> post;
}
