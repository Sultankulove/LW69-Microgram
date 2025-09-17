package midel;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Getter
@Setter
@Entity
@Table(name = "likes")
public class Like {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @Column(name = "user_id")
    private User userId;

    @ManyToOne
    @Column(name = "post_id")
    private Post postId;

    @Column(name = "created_at")
    private Timestamp createdAt;
}
