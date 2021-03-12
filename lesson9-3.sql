-- 1. �������� �������� ������� hello(), ������� ����� ���������� �����������, 
-- � ����������� �� �������� ������� �����. � 6:00 �� 12:00 ������� ������ ���������� 
-- ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", 
-- � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".

DELIMITER //
SELECT NOW(), HOUR(NOW())//

CREATE FUNCTION get_hour()
RETURNS INT NOT DETERMINISTIC
BEGIN
	RETURN HOUR(NOW());
END//

SELECT get_hour()//

DROP FUNCTION IF EXISTS time_hello;
DELIMITER //
CREATE FUNCTION time_hello()
RETURNS TINYTEXT NO SQL
BEGIN
	DECLARE hour INT;
	SET hour = HOUR(NOW());
	    CASE
			WHEN hour BETWEEN 0 AND 5 THEN
				RETURN "������� ����";
			WHEN hour BETWEEN 6 AND 11 THEN
				RETURN "������ ����";
			WHEN hour BETWEEN 12 AND 17 THEN
				RETURN "������ ����";
			WHEN hour BETWEEN 18 AND 23 THEN
				RETURN "����� �����";
		END CASE;
END//
DELIMITER;

SELECT NOW(),time_hello()//


-- 2. � ������� products ���� ��� ��������� ����: name � ��������� ������ 
-- � description � ��� ���������. ��������� ����������� ����� ����� ��� ���� �� ���. 
-- ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. 
-- ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������. 
-- ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.

DELIMITER //
CREATE TRIGGER notNulltrigger BEFORE INSERT ON products 
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.descrition IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "������ ������� �������� - ��� �������� NULL";
	END CASE;
END//

CREATE TRIGGER notNulltrigger BEFORE UPDATE ON products 
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.descrition IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "������ ������� �������� - ��� �������� NULL";
	END CASE;
END//
DELIMITER;

