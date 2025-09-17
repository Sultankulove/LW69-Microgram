package kg.attractor.java25.microgram.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "posts",
        indexes = {
                @Index(name = "ix_posts_author_created", columnList = "author_id, created_at")
        })
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "author_id", nullable = false)
    private User author;

    @Column(name = "image")
    private String image;

    @Column(name = "description")
    private String description;

    @Column(name = "likes_count", nullable = false)
    private Integer likesCount = 0;

    @Column(name = "comments_count", nullable = false)
    private Integer commentsCount = 0;

    @CreationTimestamp
    @Column(name = "created_at")
    private Timestamp createdAt;

    @OneToMany(mappedBy = "post", cascade = CascadeType.REMOVE, orphanRemoval = true)
    @JsonIgnore
    private List<Comment> comments = new ArrayList<>();

    @OneToMany(mappedBy = "post", cascade = CascadeType.REMOVE, orphanRemoval = true)
    @JsonIgnore
    private List<Like> likes = new ArrayList<>();

}