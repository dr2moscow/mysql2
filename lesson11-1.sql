-- 1. �������� ������� logs ���� Archive. ����� ��� ������ �������� ������ � �������� users, 
-- catalogs � products � ������� logs ���������� ����� � ���� �������� ������, �������� �������, 
-- ������������� ���������� ����� � ���������� ���� name.
--	id INT NOT NULL COMMENT 'ID ������ � ����'
--	table_name VARCHAR(255) NOT NULL COMMENT '�������� ������� ������� ��������',


USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	id INT UNSIGNED NOT NULL COMMENT '�������������� ���������� �����',
	table_name VARCHAR(255) NOT NULL COMMENT '�������� ������� ������� ��������',
 	value_name VARCHAR(255) COMMENT '���������� ���� name',
	created_at DATETIME DEFAULT current_timestamp COMMENT '��������� ����� � ���� ������ � ����'
) ENGINE = ARCHIVE COMMENT '��� ��������� � ��';

-- ���������
DESCRIBE logs;

Field     |Type        |Null|Key|Default          |Extra            |
----------|------------|----|---|-----------------|-----------------|
logs_id   |int         |NO  |   |                 |                 |
table_name|varchar(255)|NO  |   |                 |                 |
value_name|varchar(255)|YES |   |                 |                 |
created_at|datetime    |YES |   |CURRENT_TIMESTAMP|DEFAULT_GENERATED|


-- �������� ��� ����������������� users
DROP TRIGGER IF EXISTS log_user_insert;
DELIMITER //
CREATE TRIGGER log_user_insert AFTER INSERT ON users
  FOR EACH ROW
  BEGIN
	  INSERT INTO logs (table_name, id, value_name) VALUES ('users', NEW.id, NEW.name);
  END //
DELIMITER ;

-- ��������� ������
INSERT INTO users(name,birthday_at) VALUES ('Ivan', '1976-01-01');

-- �������� ��� ����������������� catalogs
DROP TRIGGER IF EXISTS log_catalogs_insert;
DELIMITER //
CREATE TRIGGER log_catalogs_insert AFTER INSERT ON catalogs
  FOR EACH ROW
  BEGIN
	  INSERT INTO logs (table_name, id, value_name) VALUES ('catalogs', NEW.id, NEW.name);
  END //
DELIMITER ;

-- ��������� ������
INSERT INTO catalogs(name) VALUES ('������');


-- �������� ��� ����������������� products
DROP TRIGGER IF EXISTS log_products_insert;
DELIMITER //
CREATE TRIGGER log_products_insert AFTER INSERT ON products
  FOR EACH ROW
  BEGIN
	  INSERT INTO logs (table_name, id, value_name) VALUES ('products', NEW.id, NEW.name);
  END //
DELIMITER ;

-- ��������� ������
INSERT INTO products(name, desription, price) VALUES ('������� �1', '������ ������ �����, �������', '100');

-- ��������� �� ������� �����������
SELECT * FROM logs;

id    |table_name|value_name|created_at         |
------|----------|----------|-------------------|
236802|users     |Ivan      |2021-03-16 19:30:38|
    11|catalogs  |������    |2021-03-16 19:31:00|
    11|products  |������� �1|2021-03-16 19:31:37|
 

-- 2. (�� �������) �������� SQL-������, ������� �������� � ������� users ������� �������.

DROP PROCEDURE IF EXISTS my_users_million;

DELIMITER //
CREATE PROCEDURE my_users_million ()
 BEGIN
	DECLARE i INT DEFAULT 20;
	WHILE i <= 999980 DO
		INSERT INTO users (name, birthday_at) VALUES ('����', '2021-03-16');
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
			('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
			('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
		    ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
	        ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
            ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
            ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
            ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
            ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
            ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
            ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
           	('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
			('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
		    ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
	        ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
            ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
            ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
            ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
            ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
            ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),
            ('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday),('����', birthday);
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

-- ���������
SELECT * FROM users_test ORDER BY id DESC LIMIT 20;

SELECT * FROM logs LIMIT 20;
id    |table_name|value_name|created_at         |
------|----------|----------|-------------------|
236802|users     |Ivan      |2021-03-16 19:30:38|
    11|catalogs  |������    |2021-03-16 19:31:00|
    11|products  |������� �1|2021-03-16 19:31:37|
236803|users     |����      |2021-03-16 19:32:24|
236804|users     |����      |2021-03-16 19:32:24|
236805|users     |����      |2021-03-16 19:32:24|
236806|users     |����      |2021-03-16 19:32:24|
236807|users     |����      |2021-03-16 19:32:24|
236808|users     |����      |2021-03-16 19:32:24|
236809|users     |����      |2021-03-16 19:32:24|
236810|users     |����      |2021-03-16 19:32:24|
236811|users     |����      |2021-03-16 19:32:24|
236812|users     |����      |2021-03-16 19:32:24|
236813|users     |����      |2021-03-16 19:32:24|
236814|users     |����      |2021-03-16 19:32:24|
236815|users     |����      |2021-03-16 19:32:24|
236816|users     |����      |2021-03-16 19:32:24|
236817|users     |����      |2021-03-16 19:32:24|
236818|users     |����      |2021-03-16 19:32:24|
236819|users     |����      |2021-03-16 19:32:24|

