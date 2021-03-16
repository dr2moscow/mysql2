-- 1. Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индекы.

USE vk;
-- пользователи будут искать друзей по известным им параметрам фамилия + имя
DROP INDEX users_name_idx ON users;
CREATE INDEX users_name_idx ON users(first_name, last_name);

-- поиск по e-mail и телефону, одбираем для индекса только уникальные
DROP INDEX users_phone_uq ON users;
DROP INDEX users_email_uq ON users;
CREATE UNIQUE INDEX users_phone_uq ON users(phone);
CREATE UNIQUE INDEX users_email_uq ON users(email);

-- поиск группы по названию, только уникальные название групп
DROP INDEX communities_name_uq ON communities;
CREATE UNIQUE INDEX communities_name_uq ON communities(name);

-- поиск среди медиафайлов по названию файлов
DROP INDEX media_filename_idx ON media;
CREATE INDEX media_filename_idx ON media(filename);

-- составной индекс для поика сообщений (message)
DROP INDEX messages_from_user_id_to_user_id_idx ON messages;
CREATE INDEX messages_from_user_id_to_user_id_idx ON messages (from_user_id, to_user_id);



-- не забываем про самое востребованное в соц.сети - like
DROP INDEX likes_user_id_idx ON likes;
DROP INDEX likes_target_id_idx ON likes;

CREATE INDEX likes_user_id_idx ON likes(user_id);
CREATE INDEX likes_target_id_idx ON likes(target_id);

-- Результат
SHOW INDEX FROM likes;
Table|Non_unique|Key_name         |Seq_in_index|Column_name   |Collation|Cardinality|
-----|----------|-----------------|------------|--------------|---------|-----------|
likes|         0|PRIMARY          |           1|id            |A        |        100|
likes|         1|likes_user_id_fk |           1|user_id       |A        |         67|
likes|         1|target_type_id_fk|           1|target_type_id|A        |          4|
likes|         1|target__id_fk    |           1|target_id     |A        |         62|

SHOW INDEX FROM messages;
Table   |Non_unique|Key_name                            |Seq_in_index|Column_name |Collation|Cardinality
--------|----------|------------------------------------|------------|------------|---------|-----------
messages|         0|PRIMARY                             |           1|id          |A        |        100
messages|         1|messages_to_user_id_fk              |           1|to_user_id  |A        |         69
messages|         1|messages_from_user_id_to_user_id_idx|           1|from_user_id|A        |         63
messages|         1|messages_from_user_id_to_user_id_idx|           2|to_user_id  |A        |        100

SHOW INDEX FROM media;
Table|Non_unique|Key_name          |Seq_in_index|Column_name  |Collation|Cardinality|
-----|----------|------------------|------------|-------------|---------|-----------|
media|         0|PRIMARY           |           1|id           |A        |        100|
media|         1|media_type_id_fk  |           1|media_type_id|A        |          3|
media|         1|media_user_id_fk  |           1|user_id      |A        |         62|
media|         1|media_filename_idx|           1|filename     |A        |         91|

SHOW INDEX FROM users;
Table|Non_unique|Key_name      |Seq_in_index|Column_name|Collation|Cardinality|
-----|----------|--------------|------------|-----------|---------|-----------|
users|         0|PRIMARY       |           1|id         |A        |        100|
users|         0|users_phone_uq|           1|phone      |A        |        100|
users|         0|users_email_uq|           1|email      |A        |        100|
users|         1|users_name_idx|           1|first_name |A        |         96|
users|         1|users_name_idx|           2|last_name  |A        |        100|

SHOW INDEX FROM communities;
able      |Non_unique|Key_name           |Seq_in_index|Column_name|Collation|Cardinalit
----------|----------|-------------------|------------|-----------|---------|----------
ommunities|         0|PRIMARY            |           1|id         |A        |         2
ommunities|         0|communities_name_uq|           1|name       |A        |         2

-- Задание на оконные функции
-- Построить запрос, который будет выводить следующие столбцы:
-- 1. имя группы; (group_name)
-- 2. среднее количество пользователей в группах; (average)
-- 3. самый молодой пользователь в группе; (min_age)
-- 4. самый старший пользователь в группе; (max_age)
-- 5. общее количество пользователей в группе; (users_on_group)
-- 6. всего пользователей в системе (users_total);
-- 7. отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100. (%%)

SELECT DISTINCT c.name AS group_name,
  COUNT(cu.user_id) OVER () / (SELECT COUNT(*) FROM communities) AS average,
  MIN(p.birthday) OVER w AS max_age,
  MAX(p.birthday) OVER w AS min_age,
  COUNT(p.user_id) OVER w AS users_on_group,
  (SELECT COUNT(*) FROM users) AS users_total,
  COUNT(p.user_id) OVER w / COUNT(p.user_id) OVER() * 100 AS "%%"
      FROM communities c
      LEFT JOIN communities_users cu ON cu.community_id = c.id
      LEFT JOIN users u ON cu.user_id = u.id
      LEFT JOIN profiles p ON p.user_id = u.id
        WINDOW w AS (PARTITION BY c.name);

-- Результат
group_name    |average|min_age   |max_age   |users_on_group|users_total|%%     |
--------------|-------|----------|----------|--------------|-----------|-------|
consequatur   | 5.0000|1998-07-28|1998-07-28|             1|        100| 1.0000|
cupiditate    | 5.0000|1937-05-24|2007-07-26|             5|        100| 5.0000|
distinctio    | 5.0000|2005-01-19|2017-08-21|             2|        100| 2.0000|
dolores       | 5.0000|1921-03-15|2020-02-01|             6|        100| 6.0000|
error         | 5.0000|1929-11-22|2006-11-19|             4|        100| 4.0000|
est           | 5.0000|1934-10-04|1936-11-17|             2|        100| 2.0000|
et            | 5.0000|1931-04-30|2019-07-23|            11|        100|11.0000|
exercitationem| 5.0000|1956-06-08|2017-04-04|             2|        100| 2.0000|
fugit         | 5.0000|1993-06-13|1993-06-13|             1|        100| 1.0000|
id            | 5.0000|1926-06-01|2007-06-20|             5|        100| 5.0000|
impedit       | 5.0000|1964-08-06|2011-03-20|             3|        100| 3.0000|
laborum       | 5.0000|1929-08-27|2013-10-31|             6|        100| 6.0000|
neque         | 5.0000|1931-09-30|2003-09-03|             5|        100| 5.0000|
nihil         | 5.0000|1990-09-16|1990-09-16|             1|        100| 1.0000|
placeat       | 5.0000|1935-02-13|2019-10-23|            10|        100|10.0000|
repellendus   | 5.0000|1924-12-01|2017-01-29|             4|        100| 4.0000|
tempora       | 5.0000|1921-04-30|2012-11-28|             9|        100| 9.0000|
ut            | 5.0000|1928-06-05|2000-07-21|             8|        100| 8.0000|
veritatis     | 5.0000|1942-01-16|2005-11-01|             9|        100| 9.0000|
vitae         | 5.0000|1928-02-16|2012-05-12|             6|        100| 6.0000|
