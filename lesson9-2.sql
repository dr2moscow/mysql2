-- ������������ ������� �� ���� ������������������ MySQL� (��� ���� ��������� �� ������ �������)
-- 1. �������� ���� ������������� ������� ����� ������ � ���� ������ shop. ������� ������������ 
-- shop_read ������ ���� �������� ������ ������� �� ������ ������, ������� ������������ shop � 
-- ����� �������� � �������� ���� ������ shop.

USE shop;
CREATE USER shop IDENTIFIED WITH sha256_password BY 'pass';
CREATE USER shop_read IDENTIFIED WITH sha256_password BY 'pass';
GRANT SELECT ON shop.* TO shop_read;
GRANT ALL ON shop.* TO shop;

SHOW GRANTS FOR shop_read;

-- ���������

SELECT HOST, USER FROM mysql.user;
-- ���������
HOST     |USER            |
---------|----------------|
%        |shop            |
%        |shop_read       |
%        |user_read       |
localhost|debian-sys-maint|
localhost|mysql.infoschema|
localhost|mysql.session   |
localhost|mysql.sys       |
localhost|root            |

SHOW GRANTS FOR shop_read;
-- ���������
Grants for shop_read@%                     |
-------------------------------------------|
GRANT USAGE ON *.* TO `shop_read`@`%`      |
GRANT SELECT ON `shop`.* TO `shop_read`@`%`|

SHOW GRANTS FOR shop;
-- ���������
Grants for shop@%                             |
----------------------------------------------|
GRANT USAGE ON *.* TO `shop`@`%`              |
GRANT ALL PRIVILEGES ON `shop`.* TO `shop`@`%`|


-- 2.(�� �������) ����� ������� ������� accounts ���������� ��� ������� id, name, password, 
-- ���������� ��������� ����, ��� ������������ � ��� ������. �������� ������������� username 
-- ������� accounts, ��������������� ������ � ������� id � name. �������� ������������ user_read, 
-- ������� �� �� ���� ������� � ������� accounts, ������, ��� �� ��������� ������ �� ������������� username.

-- ��������� ������� accounts
USE shop;
DROP TABLE IF EXISTS acoounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  password VARCHAR(20),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

CREATE VIEW username AS SELECT id, name FROM accounts;
CREATE USER user_read IDENTIFIED WITH sha256_password BY 'pass';
-- ������������ ��� ����, ����� � ������������� ������� accounts

GRANT SELECT on username TO user_read;
-- ������������� ����� �� ���������� ������� �� ������������� username	