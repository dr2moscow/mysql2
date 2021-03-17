-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

-- Устанавливаем Redis
apt install redis-server


127.0.0.1:6379> HMSET ip_addr 127.0.0.1 1 192.168.0.2 2
127.0.0.1:6379> HKEYS ip_addr
127.0.0.1:6379> HVALS ip_addr
127.0.0.1:6379> HSET ip_addr 192.168.1.11 3

-- Результат
127.0.0.1:6379> HGETALL ip_addr
1) "127.0.0.1"
2) "1"
3) "192.168.0.2"
4) "2"
5) "192.168.0.10"
6) "1"
7) "192.168.1.11"
8) "3"


-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.
127.0.0.1:6379> MSET a@mail.ru avram avram a@mail.ru benigud b@mail.ru b@mail.ru benigud

-- Результа
127.0.0.1:6379> KEYS *
1) "benigud"
2) "avram"
3) "b@mail.ru"
4) "a@mail.ru"

127.0.0.1:6379> GET avram
"a@mail.ru"

127.0.0.1:6379> GET a@mail.ru
"avram"

127.0.0.1:6379> GET benigud
"b@mail.ru"

127.0.0.1:6379> GET b@mail.ru
"benigud"



-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
-- Устанавливаем MongoDB
apt install mongodb-server
apt install mongodb-client


-- catalogs:
use catlogs
db.dropDatabase()
db.catalogs.insertMany([
	{"name": "Процессоры"},
	{"name": "Материнские платы"},
	{"name": "Видеокарты"},
	{"name": "Жесткие диски"},
	{"name": "Оперативная память"}
	])

-- Результат
db.catalogs.find()

{ "_id" : ObjectId("605217b0bc013dd2dfee3edc"), "name" : "Процессоры" }
{ "_id" : ObjectId("605217b0bc013dd2dfee3edd"), "name" : "Материнские платы" }
{ "_id" : ObjectId("605217b0bc013dd2dfee3ede"), "name" : "Видеокарты" }
{ "_id" : ObjectId("605217b0bc013dd2dfee3edf"), "name" : "Жесткие диски" }
{ "_id" : ObjectId("605217b0bc013dd2dfee3ee0"), "name" : "Оперативная память" }


-- users:
use users
db.dropDatabase()
db.users.insertMany([
	{"name": "Геннадий", "birthday_at": "1990-10-05", "created_at": Date(), "updated_at": Date()},
	{"name": "Наталья", "birthday_at": "1984-11-12","created_at": Date(), "updated_at": Date()},
	{"name": "Александр", "birthday_at": "1985-05-20","created_at": Date(), "updated_at": Date()},
	{"name": "Сергей", "birthday_at": "1988-02-14","created_at": Date(), "updated_at": Date()},
	{"name": "Иван", "birthday_at": "1998-01-12","created_at": Date(), "updated_at": Date()},
	{"name": "Мария", "birthday_at": "1992-08-29","created_at": Date(), "updated_at": Date()}
	])

-- Результат
db.users.find()
{ "_id" : ObjectId("605247e75fd9ecde16cbab3f"), "name" : "Геннадий", "birthday_at" : "1990-10-05", "created_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)" }
{ "_id" : ObjectId("605247e75fd9ecde16cbab40"), "name" : "Наталья", "birthday_at" : "1984-11-12", "created_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)" }
{ "_id" : ObjectId("605247e75fd9ecde16cbab41"), "name" : "Александр", "birthday_at" : "1985-05-20", "created_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)" }
{ "_id" : ObjectId("605247e75fd9ecde16cbab42"), "name" : "Сергей", "birthday_at" : "1988-02-14", "created_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)" }
{ "_id" : ObjectId("605247e75fd9ecde16cbab43"), "name" : "Иван", "birthday_at" : "1998-01-12", "created_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)" }
{ "_id" : ObjectId("605247e75fd9ecde16cbab44"), "name" : "Мария", "birthday_at" : "1992-08-29", "created_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)" }


-- products:
use products
db.dropDatabase()
db.products.insertMany([
	{"name": "Intel Core i3-8100", "description": "Процессор для настольных ПК Intel", "price": "7890.00", "catalog_id": "Процессоры", "created_at": Date(), "updated_at": Date()},
	{"name": "Intel Core i5-7400", "description": "Процессор для настольных ПК Intel", "price": "12700.00", "catalog_id": "Процессоры", "created_at": Date(), "updated_at": Date()},
	{"name": "AMD FX-8320E", "description": "Процессор для настольных ПК AMD", "price": "4780.00", "catalog_id": "Процессоры", "created_at": Date(), "updated_at": Date()},
	{"name": "AMD FX-8320", "description": "Процессор для настольных ПК AMD", "price": "7120.00", "catalog_id": "Процессоры", "created_at": Date(), "updated_at": Date()},
	{"name": "ASUS ROG MAXIMUS X HERO", "description": "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX", "price": "19310.00", "catalog_id": "Материнские платы", "created_at": Date(), "updated_at": Date()},
	{"name": "Gigabyte H310M S2H", "description": "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX", "price": "4790.00", "catalog_id": "Материнские платы", "created_at": Date(), "updated_at": Date()},
	{"name": "MSI B250M GAMING PRO", "description": "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX", "price": "5060.00", "catalog_id": "Материнские платы", "created_at": Date(), "updated_at": Date()}
	])

-- Результа
db.products.find()
{ "_id" : ObjectId("6052484d5fd9ecde16cbab45"), "name" : "Intel Core i3-8100", "description" : "Процессор для настольных ПК Intel", "price" : "7890.00", "catalog_id" : "Процессоры", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }
{ "_id" : ObjectId("6052484d5fd9ecde16cbab46"), "name" : "Intel Core i5-7400", "description" : "Процессор для настольных ПК Intel", "price" : "12700.00", "catalog_id" : "Процессоры", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }
{ "_id" : ObjectId("6052484d5fd9ecde16cbab47"), "name" : "AMD FX-8320E", "description" : "Процессор для настольных ПК AMD", "price" : "4780.00", "catalog_id" : "Процессоры", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }
{ "_id" : ObjectId("6052484d5fd9ecde16cbab48"), "name" : "AMD FX-8320", "description" : "Процессор для настольных ПК AMD", "price" : "7120.00", "catalog_id" : "Процессоры", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }
{ "_id" : ObjectId("6052484d5fd9ecde16cbab49"), "name" : "ASUS ROG MAXIMUS X HERO", "description" : "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX", "price" : "19310.00", "catalog_id" : "Материнские платы", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }
{ "_id" : ObjectId("6052484d5fd9ecde16cbab4a"), "name" : "Gigabyte H310M S2H", "description" : "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX", "price" : "4790.00", "catalog_id" : "Материнские платы", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }
{ "_id" : ObjectId("6052484d5fd9ecde16cbab4b"), "name" : "MSI B250M GAMING PRO", "description" : "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX", "price" : "5060.00", "catalog_id" : "Материнские платы", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }