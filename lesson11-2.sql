-- 1. � ���� ������ Redis ��������� ��������� ��� �������� ��������� � ������������ IP-�������.

-- ������������� Redis
apt install redis-server


127.0.0.1:6379> HMSET ip_addr 127.0.0.1 1 192.168.0.2 2
127.0.0.1:6379> HKEYS ip_addr
127.0.0.1:6379> HVALS ip_addr
127.0.0.1:6379> HSET ip_addr 192.168.1.11 3

-- ���������
127.0.0.1:6379> HGETALL ip_addr
1) "127.0.0.1"
2) "1"
3) "192.168.0.2"
4) "2"
5) "192.168.0.10"
6) "1"
7) "192.168.1.11"
8) "3"


-- 2. ��� ������ ���� ������ Redis ������ ������ ������ ����� ������������ �� ������������ ������ � ��������, ����� ������������ ������ ������������ �� ��� �����.
127.0.0.1:6379> MSET a@mail.ru avram avram a@mail.ru benigud b@mail.ru b@mail.ru benigud

-- ��������
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



-- 3. ����������� �������� ��������� � �������� ������� ������� ���� ������ shop � ���� MongoDB.
-- ������������� MongoDB
apt install mongodb-server
apt install mongodb-client


-- catalogs:
use catlogs
db.dropDatabase()
db.catalogs.insertMany([
	{"name": "����������"},
	{"name": "����������� �����"},
	{"name": "����������"},
	{"name": "������� �����"},
	{"name": "����������� ������"}
	])

-- ���������
db.catalogs.find()

{ "_id" : ObjectId("605217b0bc013dd2dfee3edc"), "name" : "����������" }
{ "_id" : ObjectId("605217b0bc013dd2dfee3edd"), "name" : "����������� �����" }
{ "_id" : ObjectId("605217b0bc013dd2dfee3ede"), "name" : "����������" }
{ "_id" : ObjectId("605217b0bc013dd2dfee3edf"), "name" : "������� �����" }
{ "_id" : ObjectId("605217b0bc013dd2dfee3ee0"), "name" : "����������� ������" }


-- users:
use users
db.dropDatabase()
db.users.insertMany([
	{"name": "��������", "birthday_at": "1990-10-05", "created_at": Date(), "updated_at": Date()},
	{"name": "�������", "birthday_at": "1984-11-12","created_at": Date(), "updated_at": Date()},
	{"name": "���������", "birthday_at": "1985-05-20","created_at": Date(), "updated_at": Date()},
	{"name": "������", "birthday_at": "1988-02-14","created_at": Date(), "updated_at": Date()},
	{"name": "����", "birthday_at": "1998-01-12","created_at": Date(), "updated_at": Date()},
	{"name": "�����", "birthday_at": "1992-08-29","created_at": Date(), "updated_at": Date()}
	])

-- ���������
db.users.find()
{ "_id" : ObjectId("605247e75fd9ecde16cbab3f"), "name" : "��������", "birthday_at" : "1990-10-05", "created_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)" }
{ "_id" : ObjectId("605247e75fd9ecde16cbab40"), "name" : "�������", "birthday_at" : "1984-11-12", "created_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)" }
{ "_id" : ObjectId("605247e75fd9ecde16cbab41"), "name" : "���������", "birthday_at" : "1985-05-20", "created_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)" }
{ "_id" : ObjectId("605247e75fd9ecde16cbab42"), "name" : "������", "birthday_at" : "1988-02-14", "created_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)" }
{ "_id" : ObjectId("605247e75fd9ecde16cbab43"), "name" : "����", "birthday_at" : "1998-01-12", "created_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)" }
{ "_id" : ObjectId("605247e75fd9ecde16cbab44"), "name" : "�����", "birthday_at" : "1992-08-29", "created_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:18:15 GMT+0000 (UTC)" }


-- products:
use products
db.dropDatabase()
db.products.insertMany([
	{"name": "Intel Core i3-8100", "description": "��������� ��� ���������� �� Intel", "price": "7890.00", "catalog_id": "����������", "created_at": Date(), "updated_at": Date()},
	{"name": "Intel Core i5-7400", "description": "��������� ��� ���������� �� Intel", "price": "12700.00", "catalog_id": "����������", "created_at": Date(), "updated_at": Date()},
	{"name": "AMD FX-8320E", "description": "��������� ��� ���������� �� AMD", "price": "4780.00", "catalog_id": "����������", "created_at": Date(), "updated_at": Date()},
	{"name": "AMD FX-8320", "description": "��������� ��� ���������� �� AMD", "price": "7120.00", "catalog_id": "����������", "created_at": Date(), "updated_at": Date()},
	{"name": "ASUS ROG MAXIMUS X HERO", "description": "����������� ����� ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX", "price": "19310.00", "catalog_id": "����������� �����", "created_at": Date(), "updated_at": Date()},
	{"name": "Gigabyte H310M S2H", "description": "����������� ����� Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX", "price": "4790.00", "catalog_id": "����������� �����", "created_at": Date(), "updated_at": Date()},
	{"name": "MSI B250M GAMING PRO", "description": "����������� ����� MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX", "price": "5060.00", "catalog_id": "����������� �����", "created_at": Date(), "updated_at": Date()}
	])

-- ��������
db.products.find()
{ "_id" : ObjectId("6052484d5fd9ecde16cbab45"), "name" : "Intel Core i3-8100", "description" : "��������� ��� ���������� �� Intel", "price" : "7890.00", "catalog_id" : "����������", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }
{ "_id" : ObjectId("6052484d5fd9ecde16cbab46"), "name" : "Intel Core i5-7400", "description" : "��������� ��� ���������� �� Intel", "price" : "12700.00", "catalog_id" : "����������", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }
{ "_id" : ObjectId("6052484d5fd9ecde16cbab47"), "name" : "AMD FX-8320E", "description" : "��������� ��� ���������� �� AMD", "price" : "4780.00", "catalog_id" : "����������", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }
{ "_id" : ObjectId("6052484d5fd9ecde16cbab48"), "name" : "AMD FX-8320", "description" : "��������� ��� ���������� �� AMD", "price" : "7120.00", "catalog_id" : "����������", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }
{ "_id" : ObjectId("6052484d5fd9ecde16cbab49"), "name" : "ASUS ROG MAXIMUS X HERO", "description" : "����������� ����� ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX", "price" : "19310.00", "catalog_id" : "����������� �����", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }
{ "_id" : ObjectId("6052484d5fd9ecde16cbab4a"), "name" : "Gigabyte H310M S2H", "description" : "����������� ����� Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX", "price" : "4790.00", "catalog_id" : "����������� �����", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }
{ "_id" : ObjectId("6052484d5fd9ecde16cbab4b"), "name" : "MSI B250M GAMING PRO", "description" : "����������� ����� MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX", "price" : "5060.00", "catalog_id" : "����������� �����", "created_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)", "updated_at" : "Wed Mar 17 2021 18:19:57 GMT+0000 (UTC)" }