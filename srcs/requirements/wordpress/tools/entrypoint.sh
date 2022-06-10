#!/bin/sh

if [ ! -f "wp-config.php" ]; then

# if the wordpress config file doesn't exists

    wp core download --allow-root

    # download wordpress

    wp config create --dbname=$DB_NAME --dbhost=$DB_HOST --dbuser=$DB_USER --dbpass=$DB_PASSWORD --allow-root

    # create wp-config.php

    wp core install --url=$WP_URL --title="${WP_TITLE}" --admin_name=$WP_ADMIN_NAME \
    --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_MAIL --allow-root

    # install wordpress

    wp user create $WP_USR_NAME $WP_USR_MAIL --user_pass=$WP_USR_PWD --role=$WP_USR_ROLE --allow-root

    # create a new user to the wordpress website

fi

/usr/sbin/php-fpm7.3 --nodaemonize

# to start php server in foreground