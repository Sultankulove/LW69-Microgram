------------------------------------------------------------
-- 1) USERS (30 шт.)
------------------------------------------------------------

-- Пароль у всех
INSERT INTO users (username, email, password, role, enabled, display_name, avatar, bio,
                   posts_count, followers_count, following_count)
VALUES
    ('elon_musk','elon.musk@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Elon Musk','avatar1.jpeg','Engineer & builder',0,0,0),
    ('tim_berners_lee','tim.lee@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Tim Berners-Lee','avatar2.jpeg','Invented the Web',0,0,0),
    ('linus_torvalds','linus.t@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Linus Torvalds','avatar3.jpeg','Linux & Git',0,0,0),
    ('guido_van_rossum','guido.py@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Guido van Rossum','avatar4.jpeg','Creator of Python',0,0,0),
    ('grace_hopper','grace.h@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Grace Hopper','avatar5.jpeg','COBOL pioneer',0,0,0),
    ('margaret_hamilton','m.hamilton@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Margaret Hamilton','avatar6.jpeg','Apollo software lead',0,0,0),
    ('ada_lovelace','ada.l@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Ada Lovelace','avatar7.jpeg','Analytical Engine notes',0,0,0),
    ('dennis_ritchie','d.ritchie@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Dennis Ritchie','avatar8.jpeg','C & Unix',0,0,0),
    ('bjarne_stroustrup','b.stroustrup@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Bjarne Stroustrup','avatar9.jpeg','C++ creator',0,0,0),
    ('james_gosling','j.gosling@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'James Gosling','avatar10.jpeg','Father of Java',0,0,0),
    ('brendan_eich','b.eich@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Brendan Eich','avatar11.jpeg','JS & Mozilla',0,0,0),
    ('jeff_bezos','jeff.b@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Jeff Bezos','avatar12.jpeg','Day 1',0,0,0),
    ('bill_gates','bill.g@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Bill Gates','avatar13.jpeg','Software & philanthropy',0,0,0),
    ('steve_jobs','steve.j@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Steve Jobs','avatar14.jpeg','Stay hungry',0,0,0),
    ('satya_nadella','satya.n@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Satya Nadella','avatar15.jpeg','Empower every person',0,0,0),
    ('sundar_pichai','sundar.p@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Sundar Pichai','avatar16.jpeg','Useful for everyone',0,0,0),
    ('mark_zuckerberg','mark.z@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Mark Zuckerberg','avatar17.jpeg','Move fast',0,0,0),
    ('larry_page','larry.p@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Larry Page','avatar18.jpeg','10x mindset',0,0,0),
    ('sergey_brin','sergey.b@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Sergey Brin','avatar19.jpeg','Curiosity-driven',0,0,0),
    ('kevin_systrom','kevin.s@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Kevin Systrom','avatar20.jpeg','Instagram cofounder',0,0,0),
    ('mike_krieger','mike.k@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Mike Krieger','avatar21.jpeg','Instagram cofounder',0,0,0),
    ('brian_acton','brian.a@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Brian Acton','avatar22.jpeg','WhatsApp',0,0,0),
    ('jan_koum','jan.k@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Jan Koum','avatar23.jpeg','WhatsApp',0,0,0),
    ('susan_wojcicki','susan.w@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Susan Wojcicki','avatar24.jpeg','YouTube',0,0,0),
    ('patrick_collison','patrick.c@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Patrick Collison','avatar25.jpeg','Stripe',0,0,0),
    ('john_carmack','john.c@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'John Carmack','avatar26.jpeg','Graphics & rockets',0,0,0),
    ('jensen_huang','jensen.h@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Jensen Huang','avatar27.jpeg','Accelerated computing',0,0,0),
    ('ilya_sutskever','ilya.s@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Ilya Sutskever','avatar28.jpeg','Deep learning',0,0,0),
    ('andrew_ng','andrew.ng@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Andrew Ng','avatar29.jpeg','AI educator',0,0,0),
    ('yoshua_bengio','yoshua.b@example.com','$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu','USER',TRUE,'Yoshua Bengio','avatar30.jpeg','AI researcher',0,0,0);

------------------------------------------------------------
-- 2) POSTS (без CTE)
------------------------------------------------------------
INSERT INTO posts (author_id, image, description, likes_count, comments_count, created_at)
SELECT
    (SELECT id FROM users u WHERE u.username = data.username),
    'image' || rn || '.jpeg',
    'Post #' || rn || ' by ' || data.username || ' — sharing an update.',
    0, 0, CURRENT_TIMESTAMP
FROM (
         SELECT
             up.username,
             seq.n,
             ROW_NUMBER() OVER () AS rn
         FROM (
                  SELECT 'elon_musk' username, 8 post_count UNION ALL
                  SELECT 'tim_berners_lee',3 UNION ALL
                  SELECT 'linus_torvalds',6 UNION ALL
                  SELECT 'guido_van_rossum',5 UNION ALL
                  SELECT 'grace_hopper',4 UNION ALL
                  SELECT 'margaret_hamilton',7 UNION ALL
                  SELECT 'ada_lovelace',3 UNION ALL
                  SELECT 'dennis_ritchie',5 UNION ALL
                  SELECT 'bjarne_stroustrup',4 UNION ALL
                  SELECT 'james_gosling',9 UNION ALL
                  SELECT 'brendan_eich',6 UNION ALL
                  SELECT 'jeff_bezos',5 UNION ALL
                  SELECT 'bill_gates',6 UNION ALL
                  SELECT 'steve_jobs',4 UNION ALL
                  SELECT 'satya_nadella',7 UNION ALL
                  SELECT 'sundar_pichai',5 UNION ALL
                  SELECT 'mark_zuckerberg',10 UNION ALL
                  SELECT 'larry_page',4 UNION ALL
                  SELECT 'sergey_brin',4 UNION ALL
                  SELECT 'kevin_systrom',6 UNION ALL
                  SELECT 'mike_krieger',4 UNION ALL
                  SELECT 'brian_acton',5 UNION ALL
                  SELECT 'jan_koum',5 UNION ALL
                  SELECT 'susan_wojcicki',4 UNION ALL
                  SELECT 'patrick_collison',6 UNION ALL
                  SELECT 'john_carmack',7 UNION ALL
                  SELECT 'jensen_huang',6 UNION ALL
                  SELECT 'ilya_sutskever',5 UNION ALL
                  SELECT 'andrew_ng',6 UNION ALL
                  SELECT 'yoshua_bengio',4
              ) up
                  JOIN (
             SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
             UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
         ) seq ON seq.n <= up.post_count
     ) data;


------------------------------------------------------------
-- 3) FOLLOWS (без CTE): каждый подписан на следующих 3-х
------------------------------------------------------------
INSERT INTO follows (follower_id, following_id, created_at)
SELECT u.id AS follower_id, v.id AS following_id, CURRENT_TIMESTAMP
FROM (
         SELECT id, username, ROW_NUMBER() OVER (ORDER BY username) AS rn
         FROM users
     ) u
         JOIN (
    SELECT id, username, ROW_NUMBER() OVER (ORDER BY username) AS rn
    FROM users
) v
              ON v.rn IN ((u.rn % 30) + 1, (u.rn % 30) + 2, (u.rn % 30) + 3);

------------------------------------------------------------
-- 4) LIKES: первые 5 пользователей лайкают все посты, кроме автора
------------------------------------------------------------
INSERT INTO likes (post_id, user_id, created_at)
SELECT p.id, u.id, CURRENT_TIMESTAMP
FROM posts p
         JOIN (SELECT id FROM users ORDER BY username LIMIT 5) top5 ON 1=1
         JOIN users u ON u.id = top5.id AND u.id <> p.author_id;

------------------------------------------------------------
-- 5) COMMENTS (без CTE): 2 комментария на пост
------------------------------------------------------------
INSERT INTO comments (post_id, author_id, text_comment, created_at)
SELECT p.id,
       (SELECT ou2.id FROM (SELECT id, ROW_NUMBER() OVER (ORDER BY username) rn FROM users) ou2
        WHERE ou2.rn = ((ou.rn) % 30) + 1),
       'Nice shot! 🔥',
       CURRENT_TIMESTAMP
FROM posts p
         JOIN (SELECT id, ROW_NUMBER() OVER (ORDER BY username) rn FROM users) ou
              ON ou.id = p.author_id
UNION ALL
SELECT p.id,
       (SELECT ou3.id FROM (SELECT id, ROW_NUMBER() OVER (ORDER BY username) rn FROM users) ou3
        WHERE ou3.rn = ((ou.rn) % 30) + 2),
       'Great update. Thanks for sharing!',
       CURRENT_TIMESTAMP
FROM posts p
         JOIN (SELECT id, ROW_NUMBER() OVER (ORDER BY username) rn FROM users) ou
              ON ou.id = p.author_id;

------------------------------------------------------------
-- 6) РЕКАЛЬКУЛЯЦИЯ СЧЁТЧИКОВ
------------------------------------------------------------
UPDATE users u
SET posts_count = COALESCE((SELECT COUNT(*) FROM posts p WHERE p.author_id = u.id), 0);

UPDATE users u
SET followers_count = COALESCE((SELECT COUNT(*) FROM follows f WHERE f.following_id = u.id), 0);

UPDATE users u
SET following_count = COALESCE((SELECT COUNT(*) FROM follows f WHERE f.follower_id = u.id), 0);

UPDATE posts p
SET likes_count = COALESCE((SELECT COUNT(*) FROM likes l WHERE l.post_id = p.id), 0);

UPDATE posts p
SET comments_count = COALESCE((SELECT COUNT(*) FROM comments c WHERE c.post_id = p.id), 0);
