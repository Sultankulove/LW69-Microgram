INSERT INTO users (username, email, password, display_name, avatar, bio, role, enabled,
                   posts_count, followers_count, following_count)
VALUES

-- админ
('admin', 'admin@admin.admin', '$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu', 'Администратор',
 'adminadminadmin.jpeg',
 'Я управляю этим местом 👑', 'ADMIN', TRUE, 0, 0, 0),

('alice', 'qwe@qwe.qwe', '$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu', 'Alice Wonder',
 'qweqweqwe.jpeg',
 'Люблю фото и путешествия 🌍', 'USER', TRUE, 0, 0, 0),

('bob', 'ewq@ewq.ewq', '$2a$10$Iitv.3WtSkUwWMlrfhM4quNPIZgSSNFvoJIRZrADASoE0eqZtMdsu', 'Bob Builder',
 'ewqewqewq.jpeg',
 'Строю дома и отношения 🛠️', 'USER', TRUE, 0, 0, 0);


-- Пароль: Qwerty123
