package midel;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Getter
@Setter
@Entity
@Table(name = "comments")
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @Column(name = "author_id")
    private User authorId;

    @ManyToOne
    @Column(name = "post_id")
    private Post postId;

    @Column(name = "textComment")
    private String textComment;

    @Column(name = "createdAt")
    private Timestamp createdAt;
}
