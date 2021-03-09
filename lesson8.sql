-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. -- Агрегация данных”
-- Использовать JOIN

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

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
      
       
-- 4. Подсчитать количество лайков которые получили 10 самых молодых пользователей.
SELECT p.user_id,
	first_name,
    last_name,
	birthday,
    COUNT(DISTINCT like_1.id) + COUNT(DISTINCT like_2.id) +COUNT(DISTINCT like_3.id) + COUNT(DISTINCT like_4.id) AS likes
FROM profiles AS p
	LEFT JOIN likes As like_1 
		ON like_1.target_id = p.user_id AND like_1.target_type_id = 2
	LEFT JOIN messages AS m
		JOIN likes AS like_2
			ON like_2.target_id = m.id AND like_2.target_type_id = 1
		ON m.from_user_id = p.user_id
	LEFT JOIN media AS d
		JOIN likes AS like_3
			ON like_3.target_id = d.id AND like_3.target_type_id = 3
		ON d.user_id = p.user_id
	LEFT JOIN posts AS s
		JOIN likes AS like_4
			ON like_4.target_id = s.id AND like_4.target_type_id = 4
		ON s.user_id = p.user_id
	LEFT JOIN users AS u
		ON p.user_id = u.id
GROUP BY p.user_id,
	first_name,
	last_name,
	birthday
ORDER BY birthday DESC LIMIT 10;
       
-- Результат     
user_id|first_name|last_name  |birthday  |likes|
-------|----------|-----------|----------|-----|
     77|Destin    |Stoltenberg|2020-02-01|    1|
     94|Larissa   |Nicolas    |2019-10-23|    3|
     50|Fabian    |Conn       |2019-07-23|    0|
     20|Woodrow   |Kemmer     |2017-08-21|    1|
     72|Zita      |Murazik    |2017-04-04|    0|
     25|Leola     |Gulgowski  |2017-01-29|    2|
      3|Gideon    |Mertz      |2013-10-31|    0|
     57|Nella     |Frami      |2012-11-28|    0|
     56|Callie    |Ankunding  |2012-10-09|    2|
     66|Dewayne   |Kuvalis    |2012-05-12|    1|
                         
    
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
GROUP BY p.user_id,
	first_name,
    last_name
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
