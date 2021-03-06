-- 1. ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.

SELECT name,
	COUNT(*) AS count_orders 
	FROM users JOIN orders ON users.id = user_id GROUP BY name;

-- ���������
name     |count_orders|
---------|------------|
�������  |           1|
���������|           1|
������   |           2|
�����    |           1|


-- 2. �������� ������ ������� products � �������� catalogs, ������� ������������� ������.
SELECT
     p.name,
     c.name AS catalog_name
  FROM
     products AS p
  JOIN
     catalogs AS c ON c.id = p.catalog_id
ORDER BY p.catalog_id, p.name;
	
-- ���������
name                   |catalog_name     |
-----------------------|-----------------|
AMD FX-8320            |����������       |
AMD FX-8320E           |����������       |
Intel Core i3-8100     |����������       |
Intel Core i5-7400     |����������       |
ASUS ROG MAXIMUS X HERO|����������� �����|
Gigabyte H310M S2H     |����������� �����|
MSI B250M GAMING PRO   |����������� �����|

-- 3. (�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). 
-- ���� from, to � label �������� ���������� �������� �������, ���� name � �������. �������� ������ 
-- ������ flights � �������� ���������� �������.

-- �������� ������� � ������
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
		('moscow', '������'),
		('kiev', '����'),
		('kazan', '������'),
		('minsk', '�����')
;

-- �������� �������
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

-- ���������
flight_id|flight_from|flight_to|
---------|-----------|---------|
        1|������     |����     |
        2|����       |������   |
        3|������     |�����    |
        5|����       |������   |
