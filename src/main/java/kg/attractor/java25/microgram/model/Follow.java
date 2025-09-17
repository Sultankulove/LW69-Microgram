package kg.attractor.java25.microgram.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Getter
@Setter
@Entity
@Table(name = "follows")
public class Follow {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "follower_id")
    private User followerId;

    @ManyToOne
    @JoinColumn(name = "following_id")
    private User followingId;

    @Column(name = "created_at")
    private Timestamp createdAt;
}
