-- Тема Операции, задание 1
-- Пусть в таблице users поля created_at и updated_at оказались незаполненными.
-- Заполните их текущими датой и временем.
USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', NULL, NULL),
  ('Наталья', '1984-11-12', NULL, NULL),
  ('Александр', '1985-05-20', NULL, NULL),
  ('Сергей', '1988-02-14', NULL, NULL),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '2006-08-29', NULL, NULL);

-- Выполнение задания №1. Заполняем 
UPDATE users SET created_at = NOW(), updated_at = NOW() WHERE created_at is NULL or updated_at is NULL;

-- Тема Операции, задание 2
-- Таблица users была неудачно спроектирована.
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались
-- значения в формате "20.10.2017 8:10".
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александр', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');

-- Выполнение задания №2. Преобразовываю без потери данных
ALTER TABLE users ADD new_created_at DATETIME;
UPDATE users SET new_created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i');
ALTER TABLE users DROP created_at, CHANGE new_created_at created_at DATETIME;

ALTER TABLE users ADD new_updated_at DATETIME;
UPDATE users SET new_updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');
ALTER TABLE users DROP updated_at, CHANGE new_updated_at updated_at DATETIME;

-- Тема Операции, задание 3
-- В таблице складских запасов storehouses_products в поле value могут встречаться самые
-- разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения
-- значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 543, 0),
  (1, 789, 2500),
  (1, 3432, 0),
  (1, 826, 30),
  (1, 719, 500),
  (1, 638, 1);
 
 -- Выполнение задания №3. Сортируем
SELECT value FROM storehouses_products ORDER BY CASE WHEN value = 0 then 1 else 0 end, value;

 
-- Тема Операции, задание 4
-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в
-- августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')
-- Используйте таблицу профилей БД ВК

-- Выполнение задания №4. Выбираем пользователей с датой рождения в may, august. Использую все еще БД shops, так как в БД VK имена пользователей вынесены за таблицу profiles где находится дата рождения

SELECT name, birthday_at FROM users WHERE MONTHNAME(birthday_at) IN ('may', 'august');


-- Тема Операции, задание 5
-- (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2);
-- Отсортируйте записи в порядке, заданном в списке IN.


INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'), 
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
 
 -- Выполнение задания №5. позици с id 5 у меня не было в таблице, заменил на 31
 SELECT* FROM catalogs WHERE id IN (31, 1, 2) ORDER BY FIELD(id, 31, 1, 2); 

-- Тема Агрегация, задание 1
-- Подсчитайте средний возраст пользователей в таблице users
-- Используйте таблицу профилей БД ВК


-- Выполнение задания №1. Расчет среднего возраста
USE vk;
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())), 0) AS AVG_Age FROM profiles;

-- Тема Агрегация, задание 2
-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года 
-- Используйте таблицу профилей БД ВК

-- Выполнение задания №2. Считаю кол-во ДР по дням недели
SELECT
    DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday, 6, 10))) AS week_day_of_birthday_in_this_year,
    COUNT(*) AS amount_of_birthday
FROM profiles
GROUP BY week_day_of_birthday_in_this_year
ORDER BY amount_of_birthday DESC;

-- Тема Агрегация, задание 3
-- (по желанию) Подсчитайте произведение чисел в столбце таблицы
INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

                                               
-- Выполнение задания №3. 
SELECT EXP(SUM(ln(id))) summ FROM catalogs;



