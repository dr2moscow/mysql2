root@joy:~#  mysql
mysql> CREATE DATABASE example DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
mysql> USE example
mysql> CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);
mysql> SHOW COLUMNS FROM users;
mysql> exit