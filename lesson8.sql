-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. -- Агрегация данных”
-- Использовать JOIN

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

-- метод с урока
SELECT profiles.gender,
	COUNT(likes.id) AS total_likes
	FROM likes
		INNER JOIN profiles 
			ON likes.user_id = profiles.user_id
		GROUP BY profiles.gender
		ORDER BY total_likes DESC LIMIT 1;

-- мой метод
SELECT COUNT(id),
	p.gender as gender
FROM likes AS l
	LEFT JOIN profiles AS p
		ON l.user_id = p.user_id GROUP BY gender
ORDER BY gender DESC LIMIT 1;



-- Результат
COUNT(id)|gender|
---------|------|
       53|w     |
      
       
-- 4. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT SUM(got_likes) AS total_likes_for_youngest
  FROM (   
    SELECT COUNT(DISTINCT likes.id) AS got_likes 
      FROM profiles
        LEFT JOIN likes
          ON likes.target_id = profiles.user_id
            AND target_type_id = 2
      GROUP BY profiles.user_id
      ORDER BY profiles.birthday DESC
      LIMIT 10
) AS youngest;   

       
-- Результат     
total_likes_for_youngest|
------------------------|
                       3|
    
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в -- использовании социальной сети -- (критерии активности необходимо определить самостоятельно).
SELECT p.user_id,
	first_name,
	last_name,
    COUNT(DISTINCT l.id) + COUNT(DISTINCT m.id) +COUNT(DISTINCT s.id) + COUNT(DISTINCT d.id) AS quantity
FROM profiles AS p
	LEFT JOIN likes As l ON l.user_id = p.user_id
	LEFT JOIN messages AS m ON m.from_user_id = p.user_id
	LEFT JOIN media AS d ON d.user_id = p.user_id
	LEFT JOIN posts AS s ON s.user_id = p.user_id
	LEFT JOIN users AS u ON p.user_id = u.id
GROUP BY p.user_id
ORDER BY quantity LIMIT 10;

-- Результат
user_id|first_name|last_name|quantity|
-------|----------|---------|--------|
     14|Everardo  |Ankunding|       0|
     23|Christy   |Labadie  |       0|
    100|Sidney    |Will     |       1|
     90|Kaley     |Hagenes  |       1|
      4|Isom      |Kiehn    |       1|
     70|Marguerite|McClure  |       1|
     54|Oliver    |Hermiston|       1|
     63|Emmitt    |Zemlak   |       1|
     27|Verla     |Lind     |       1|
     49|Violette  |Sporer   |       2|
