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

CALL my_users_million();

-- ���������
SELECT * FROM users LIMIT 20;
id    |name     |birthday_at|created_at         |updated_at         |
------|---------|-----------|-------------------|-------------------|
     1|�������� | 1990-10-05|2021-03-06 18:19:23|2021-03-06 18:19:23|
     2|�������  | 1984-11-12|2021-03-06 18:19:23|2021-03-06 18:19:23|
     3|���������| 1985-05-20|2021-03-06 18:19:23|2021-03-06 18:19:23|
     4|������   | 1988-02-14|2021-03-06 18:19:23|2021-03-06 18:19:23|
     5|����     | 1998-01-12|2021-03-06 18:19:23|2021-03-06 18:19:23|
     6|�����    | 1992-08-29|2021-03-06 18:19:23|2021-03-06 18:19:23|
    10|Ivan     | 1976-01-01|2021-03-16 18:44:01|2021-03-16 18:44:01|
    11|Ivan     | 1976-01-01|2021-03-16 18:50:49|2021-03-16 18:50:49|
236792|����     | 2021-03-16|2021-03-16 19:28:20|2021-03-16 19:28:20|
236793|����     | 2021-03-16|2021-03-16 19:28:20|2021-03-16 19:28:20|
236794|����     | 2021-03-16|2021-03-16 19:28:20|2021-03-16 19:28:20|
236795|����     | 2021-03-16|2021-03-16 19:28:20|2021-03-16 19:28:20|
236796|����     | 2021-03-16|2021-03-16 19:28:20|2021-03-16 19:28:20|
236797|����     | 2021-03-16|2021-03-16 19:28:20|2021-03-16 19:28:20|
236798|����     | 2021-03-16|2021-03-16 19:28:20|2021-03-16 19:28:20|
236799|����     | 2021-03-16|2021-03-16 19:28:20|2021-03-16 19:28:20|
236800|����     | 2021-03-16|2021-03-16 19:28:20|2021-03-16 19:28:20|
236801|����     | 2021-03-16|2021-03-16 19:28:20|2021-03-16 19:28:20|
236802|Ivan     | 1976-01-01|2021-03-16 19:30:38|2021-03-16 19:30:38|
236803|����     | 2021-03-16|2021-03-16 19:32:24|2021-03-16 19:32:24|

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

