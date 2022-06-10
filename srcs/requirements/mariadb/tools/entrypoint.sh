#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then

    # if the mysql database does not exist

    mysql_install_db --auth-root-socket-user=USER # --auth-root-authentication-method=normal

    # initializes the MariaDB data directory and creates the system tables in the mysql database

fi

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

    # if the wordpress database does not exist

    service mysql start

    mysql -u root -e "  DROP DATABASE IF EXISTS ${DB_NAME}"
    mysql -u root -e "  CREATE DATABASE IF NOT EXISTS ${DB_NAME}"

    # the database that will be used with the wordpress website is created

    mysql -u root -e "  CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}'"
    mysql -u root -e "  GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' \
                        IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION"
    mysql -u root -e "  FLUSH PRIVILEGES"

    # a new user identified by DB_USER & DB_PASSWORD (the same as in the wp-config) is created
    # he can connect to the database DB_NAME from any IP

    service mysql stop
fi

echo "ALTER USER 'root'@'localhost'IDENTIFIED BY '${DB_ROOT_PWD}';" > /var/lib/mysql/pass-reset
mysqld_safe --init-file=/var/lib/mysql/pass-reset

# used to keep mariadb running in foreground and to set up the root credentials to connect to mysql database.

# mysql_secure_connection

# used to set root user password, remove anonymous users, disallow remote root login and remove test database.

# SELECT User, Host FROM mysql.user; to show 'user'@'host'