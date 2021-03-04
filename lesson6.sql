-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. -- Агрегация данных”

-- Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:

-- 1. Создать и заполнить таблицы лайков и постов. USE vk;

-- Таблица лайков
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Таблица типов лайков
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');

-- Заполняем лайки
INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 100)), 
    FLOOR(1 + (RAND() * 100)),
    FLOOR(1 + (RAND() * 4)),
    CURRENT_TIMESTAMP 
  FROM messages;

-- Создадим таблицу постов
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  is_public BOOLEAN DEFAULT TRUE,
  is_archived BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
 
-- 2. Создать все необходимые внешние ключи и диаграмму отношений.

ALTER TABLE 
	posts 
		ADD CONSTRAINT post_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id),
		ADD CONSTRAINT post_community_id_fk FOREIGN KEY (community_id) REFERENCES communities(id),
		ADD CONSTRAINT post_media_id_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE 
	communities_users 
		ADD CONSTRAINT communities_users_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id),
		ADD CONSTRAINT communities_users_community_id_fk FOREIGN KEY (community_id) REFERENCES communities(id);

ALTER TABLE 
	media
		ADD CONSTRAINT media_type_id_fk FOREIGN KEY (media_type_id) REFERENCES media_types(id),
		ADD CONSTRAINT media_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE
	likes
		ADD CONSTRAINT likes_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id),
		ADD CONSTRAINT target_id_fk FOREIGN KEY (target_id) REFERENCES users(id);

ALTER TABLE 
	friendship
		ADD CONSTRAINT friendship_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE
	friendship
		ADD CONSTRAINT friendship_friend_id_fk FOREIGN KEY (friend_id) REFERENCES users(id),
		ADD CONSTRAINT friendship_friendship_status_id_fk FOREIGN KEY (friendship_status_id) REFERENCES friendship_statuses(id);

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT COUNT(id), 
	(SELECT gender FROM profiles WHERE user_id=likes.user_id) AS gender
FROM likes GROUP BY gender ORDER BY count(id) DESC LIMIT 1;

-- Результат
COUNT(id)|gender|
---------|------|
       53|w     |

-- Проверяем себя
SELECT COUNT(id), 
	(SELECT gender FROM profiles WHERE user_id=likes.user_id) AS gender
FROM likes GROUP BY gender ORDER BY count(id) DESC LIMIT 2;

-- Результат
COUNT(id)|gender|
---------|------|
       53|w     |
       47|m     |
       
SELECT
	(SELECT CONCAT(first_name, ' ', last_name) 
		FROM users WHERE id = user_id) AS user, 
		gender,
	(SELECT COUNT(*) 
		FROM likes WHERE target_id = profiles.user_id) AS likes
FROM profiles ORDER BY gender;


       
       
-- 4. Подсчитать количество лайков которые получили 10 самых молодых пользователей.
SELECT SUM(likes.summ) AS 10_younges7t_users_likes_sum
  FROM (SELECT 
    (SELECT COUNT(*)
    	FROM likes WHERE target_id = profiles.user_id) AS summ
       FROM profiles
      ORDER BY birthday DESC LIMIT 10) AS likes;
     
-- Результат     
10_youngest_users_likes_sum|
---------------------------|
                         12|
                         
-- Проверяем себя                         
SELECT
	(SELECT CONCAT(first_name, ' ', last_name) 
		FROM users WHERE id = user_id) AS user,
	birthday,
	(SELECT COUNT(*) 
		FROM likes WHERE target_id = profiles.user_id) AS likes
FROM profiles ORDER BY birthday DESC LIMIT 10

-- Результат   
user              |birthday  |likes|
------------------|----------|-----|
Destin Stoltenberg|2020-02-01|    1|
Larissa Nicolas   |2019-10-23|    2|
Fabian Conn       |2019-07-23|    2|
Woodrow Kemmer    |2017-08-21|    0|
Zita Murazik      |2017-04-04|    2|
Leola Gulgowski   |2017-01-29|    2|
Gideon Mertz      |2013-10-31|    0|
Nella Frami       |2012-11-28|    1|
Callie Ankunding  |2012-10-09|    2|
Dewayne Kuvalis   |2012-05-12|    0|
     
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в -- использовании социальной сети -- (критерии активности необходимо определить самостоятельно).

SELECT CONCAT(first_name, ' ', last_name) as user_name, 
	COALESCE((SELECT COUNT(*) as like_number FROM likes WHERE users.id = likes.user_id GROUP BY user_id), 0) +
	COALESCE((SELECT COUNT(*) as message_number FROM messages WHERE users.id = messages.from_user_id GROUP BY from_user_id), 0) +
	COALESCE((SELECT COUNT(*) as posts_number FROM posts WHERE users.id = posts.user_id GROUP BY user_id), 0) +
	COALESCE((SELECT COUNT(*) as communities_number FROM communities_users WHERE users.id = communities_users.user_id GROUP BY user_id), 0) +
	COALESCE((SELECT COUNT(*) as friends_number FROM friendship WHERE users.id = friendship.user_id GROUP BY user_id), 0) + 
	COALESCE((SELECT COUNT(*) as media_number FROM media WHERE users.id = media.user_id GROUP BY user_id), 0) as activity_summ 
FROM users ORDER BY activity_summ LIMIT 10;

-- Результат
user_name         |activity_summ|
------------------|-------------|
Kaley Hagenes     |            2|
Everardo Ankunding|            2|
Sidney Will       |            2|
Christy Labadie   |            2|
Libby Mitchell    |            3|
Isom Kiehn        |            3|
Madaline Herzog   |            3|
Bartholome Maggio |            3|
Oliver Hermiston  |            3|
Verla Lind        |            3|

