package kg.attractor.java25.microgram.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "posts")
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "author_id")
    private User authorId;

    private String image;
    private String description;

    @Column(name = "likes_count")
    private Integer likesCount;

    @Column(name = "comments_count")
    private Integer commentsCount;

    @Column(name = "created_at")
    private Timestamp createdAt;


    @OneToMany(mappedBy = "postId",cascade = CascadeType.ALL)
    private List<Comment> comments;

    @OneToMany(mappedBy = "postId", cascade = CascadeType.ALL)
    private List<Like> likes;

}
