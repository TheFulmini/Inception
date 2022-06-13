#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then

    mysql_install_db --auth-root-socket-user=USER # --auth-root-authentication-method=normal

fi

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

    service mysql start

    mysql -u root -e "  DROP DATABASE IF EXISTS ${DB_NAME}"
    mysql -u root -e "  CREATE DATABASE IF NOT EXISTS ${DB_NAME}"

    mysql -u root -e "  CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}'"
    mysql -u root -e "  GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' \
                        IDENTIFIED BY '${DB_PASSWORD}' WITH GRANT OPTION"
    mysql -u root -e "  FLUSH PRIVILEGES"

    service mysql stop
fi

echo "ALTER USER 'root'@'localhost'IDENTIFIED BY '${DB_ROOT_PWD}';" > /var/lib/mysql/pass-reset
mysqld_safe --init-file=/var/lib/mysql/pass-reset
