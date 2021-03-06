-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT name,
	COUNT(*) AS count_orders 
	FROM users JOIN orders ON users.id = user_id GROUP BY name;

-- Результат
name     |count_orders|
---------|------------|
Наталья  |           1|
Александр|           1|
Сергей   |           2|
Мария    |           1|


-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT
     p.name,
     c.name AS catalog_name
  FROM
     products AS p
  JOIN
     catalogs AS c ON c.id = p.catalog_id
ORDER BY p.catalog_id, p.name;
	
-- Результат
name                   |catalog_name     |
-----------------------|-----------------|
AMD FX-8320            |Процессоры       |
AMD FX-8320E           |Процессоры       |
Intel Core i3-8100     |Процессоры       |
Intel Core i5-7400     |Процессоры       |
ASUS ROG MAXIMUS X HERO|Материнские платы|
Gigabyte H310M S2H     |Материнские платы|
MSI B250M GAMING PRO   |Материнские платы|

-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список 
-- рейсов flights с русскими названиями городов.

-- Геннерим таблицы и данные
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	flight_from VARCHAR(255),
	flight_to VARCHAR(255)
);

INSERT INTO flights(flight_from, flight_to) 
	VALUES 
		('moscow', 'kiev'),
		('kiev', 'kazan'),
		('kazan', 'minsk'),
		('mins', 'kazan'),
		('kiev', 'moscow')
;

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	id SERIAL PRIMARY KEY,
	label VARCHAR(255),
	name VARCHAR(255)
);

INSERT INTO cities(label, name) 
	VALUES 
		('moscow', 'Москва'),
		('kiev', 'Киев'),
		('kazan', 'Казань'),
		('minsk', 'Минск')
;

-- Выполням задание
SELECT
     f.id AS flight_id,
     c1.name AS flight_from,
     c2.name AS flight_to
  FROM
     flights AS f
  JOIN
     cities AS c1
  JOIN
     cities AS c2
    ON c1.label = f.flight_from AND c2.label = f.flight_to
 ORDER BY flight_id;

-- Результат
flight_id|flight_from|flight_to|
---------|-----------|---------|
        1|Москва     |Киев     |
        2|Киев       |Казань   |
        3|Казань     |Минск    |
        5|Киев       |Москва   |
