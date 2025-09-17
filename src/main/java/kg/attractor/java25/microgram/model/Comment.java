package kg.attractor.java25.microgram.model;

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
    @JoinColumn(name = "author_id")
    private User authorId;

    @ManyToOne
    @JoinColumn(name = "post_id")
    private Post postId;

    @Column(name = "text_comment")
    private String textComment;

    @Column(name = "created_at")
    private Timestamp createdAt;


}
