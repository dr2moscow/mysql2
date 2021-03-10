-- ѕрактическое задание по теме Ујдминистрирование MySQLФ (эта тема изучаетс€ по вашему желанию)
-- 1. —оздайте двух пользователей которые имеют доступ к базе данных shop. ѕервому пользователю 
-- shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop Ч 
-- любые операции в пределах базы данных shop.

USE shop;
CREATE USER shop IDENTIFIED WITH sha256_password BY 'pass';
CREATE USER shop_read IDENTIFIED WITH sha256_password BY 'pass';
GRANT SELECT ON shop.* TO shop_read;
GRANT ALL ON shop.* TO shop;

SHOW GRANTS FOR shop_read;

-- ѕровер€ем

SELECT HOST, USER FROM mysql.user;
-- –езультат
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
-- –езультат
Grants for shop_read@%                     |
-------------------------------------------|
GRANT USAGE ON *.* TO `shop_read`@`%`      |
GRANT SELECT ON `shop`.* TO `shop_read`@`%`|

SHOW GRANTS FOR shop;
-- –езультат
Grants for shop@%                             |
----------------------------------------------|
GRANT USAGE ON *.* TO `shop`@`%`              |
GRANT ALL PRIVILEGES ON `shop`.* TO `shop`@`%`|


-- 2.(по желанию) ѕусть имеетс€ таблица accounts содержаща€ три столбца id, name, password, 
-- содержащие первичный ключ, им€ пользовател€ и его пароль. —оздайте представление username 
-- таблицы accounts, предоставл€ющий доступ к столбца id и name. —оздайте пользовател€ user_read, 
-- который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представлени€ username.

-- добавл€ем таблицу accounts
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
-- пользователь без прав, числе и просматривать таблицу accounts

GRANT SELECT on username TO user_read;
-- предоставлены права на извлечение записей из представлени€ username	