CREATE DATABASE IF NOT EXISTS wordpress;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PWD' with GRANT OPTION;
FLUSH PRIVILEGES;