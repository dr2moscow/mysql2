-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
-- catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, 
-- идентификатор первичного ключа и содержимое поля name.
--	id INT NOT NULL COMMENT 'ID записи в логе'
--	table_name VARCHAR(255) NOT NULL COMMENT 'Название таблицы которую логируем',


USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	id INT UNSIGNED NOT NULL COMMENT 'Индентификатор первичного ключа',
	table_name VARCHAR(255) NOT NULL COMMENT 'Название таблицы которую логируем',
 	value_name VARCHAR(255) COMMENT 'Содержимое поле name',
	created_at DATETIME DEFAULT current_timestamp COMMENT 'Фиксируем время и дату записи в логе'
) ENGINE = ARCHIVE COMMENT 'Лог изменений в ИМ';

-- Результат
DESCRIBE logs;

Field     |Type        |Null|Key|Default          |Extra            |
----------|------------|----|---|-----------------|-----------------|
logs_id   |int         |NO  |   |                 |                 |
table_name|varchar(255)|NO  |   |                 |                 |
value_name|varchar(255)|YES |   |                 |                 |
created_at|datetime    |YES |   |CURRENT_TIMESTAMP|DEFAULT_GENERATED|


-- Логируем при обновлениитаблицы users
DROP TRIGGER IF EXISTS log_user_insert;
DELIMITER //
CREATE TRIGGER log_user_insert AFTER INSERT ON users
  FOR EACH ROW
  BEGIN
	  INSERT INTO logs (table_name, id, value_name) VALUES ('users', NEW.id, NEW.name);
  END //
DELIMITER ;

-- Добавляем данные
INSERT INTO users(name,birthday_at) VALUES ('Ivan', '1976-01-01');

-- Логируем при обновлениитаблицы catalogs
DROP TRIGGER IF EXISTS log_catalogs_insert;
DELIMITER //
CREATE TRIGGER log_catalogs_insert AFTER INSERT ON catalogs
  FOR EACH ROW
  BEGIN
	  INSERT INTO logs (table_name, id, value_name) VALUES ('catalogs', NEW.id, NEW.name);
  END //
DELIMITER ;

-- Добавляем данные
INSERT INTO catalogs(name) VALUES ('Кирпич');


-- Логируем при обновлениитаблицы products
DROP TRIGGER IF EXISTS log_products_insert;
DELIMITER //
CREATE TRIGGER log_products_insert AFTER INSERT ON products
  FOR EACH ROW
  BEGIN
	  INSERT INTO logs (table_name, id, value_name) VALUES ('products', NEW.id, NEW.name);
  END //
DELIMITER ;

-- Добавляем данные
INSERT INTO products(name, desription, price) VALUES ('Кирпичь А1', 'Кирпич ручной лепки, красный', '100');

-- Результат из таблицы логирования
SELECT * FROM logs;

id    |table_name|value_name|created_at         |
------|----------|----------|-------------------|
236802|users     |Ivan      |2021-03-16 19:30:38|
    11|catalogs  |Кирпич    |2021-03-16 19:31:00|
    11|products  |Кирпичь А1|2021-03-16 19:31:37|
 

-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

DROP PROCEDURE IF EXISTS my_users_million;

DELIMITER //
CREATE PROCEDURE my_users_million ()
 BEGIN
	DECLARE i INT DEFAULT 20;
	WHILE i <= 999980 DO
		INSERT INTO users (name, birthday_at) VALUES ('Иван', '2021-03-16');
		SET i = i + 1;
	END WHILE;
 END //
DELIMITER ;

DROP TABLE IF EXISTS users_test;
CREATE TABLE users_test(
	id SERIAL PRIMARY KEY,
	name VARCHAR(10) NOT NULL,
	birthday VARCHAR(10)
);

DROP PROCEDURE IF EXISTS my_users_million;
DELIMITER //
CREATE PROCEDURE my_users_million()
BEGIN
	DECLARE birthday VARCHAR(10);
	DECLARE i INT DEFAULT 1;
	WHILE i <= 5000 DO
		SET birthday = CONCAT(FLOOR(RAND()*(2002-1960+1)+1960),'-',FLOOR(RAND()*(12-1+1)+1),'-',FLOOR(RAND()*(28-1+1)+1));
		INSERT INTO users_test (name, birthday) VALUES 
			('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
			('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
		    ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
	        ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
            ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
            ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
            ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
            ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
            ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
            ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
           	('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
			('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
		    ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
	        ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
            ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
            ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
            ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
            ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
            ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),
            ('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday),('Иван', birthday);
	END WHILE;
END//
DELIMITER ;

CALL my_users_million;

DROP TABLE IF EXISTS users_test ;
CREATE TABLE users_test(
	id SERIAL PRIMARY KEY,
	name VARCHAR(10) NOT NULL,
	birthday VARCHAR(10)
) ;

INSERT INTO users SELECT * FROM users_test ;

-- Результат
SELECT * FROM users_test ORDER BY id DESC LIMIT 20;

SELECT * FROM logs LIMIT 20;
id    |table_name|value_name|created_at         |
------|----------|----------|-------------------|
236802|users     |Ivan      |2021-03-16 19:30:38|
    11|catalogs  |Кирпич    |2021-03-16 19:31:00|
    11|products  |Кирпичь А1|2021-03-16 19:31:37|
236803|users     |Иван      |2021-03-16 19:32:24|
236804|users     |Иван      |2021-03-16 19:32:24|
236805|users     |Иван      |2021-03-16 19:32:24|
236806|users     |Иван      |2021-03-16 19:32:24|
236807|users     |Иван      |2021-03-16 19:32:24|
236808|users     |Иван      |2021-03-16 19:32:24|
236809|users     |Иван      |2021-03-16 19:32:24|
236810|users     |Иван      |2021-03-16 19:32:24|
236811|users     |Иван      |2021-03-16 19:32:24|
236812|users     |Иван      |2021-03-16 19:32:24|
236813|users     |Иван      |2021-03-16 19:32:24|
236814|users     |Иван      |2021-03-16 19:32:24|
236815|users     |Иван      |2021-03-16 19:32:24|
236816|users     |Иван      |2021-03-16 19:32:24|
236817|users     |Иван      |2021-03-16 19:32:24|
236818|users     |Иван      |2021-03-16 19:32:24|
236819|users     |Иван      |2021-03-16 19:32:24|

