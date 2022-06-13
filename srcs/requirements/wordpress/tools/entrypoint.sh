#!/bin/sh

if [ ! -f "wp-config.php" ]; then

    wp core download --allow-root

    wp config create --dbname=$DB_NAME --dbhost=$DB_HOST --dbuser=$DB_USER --dbpass=$DB_PASSWORD --allow-root

    wp core install --url=$WP_URL --title="${WP_TITLE}" --admin_name=$WP_ADMIN_NAME \

    wp user create $WP_USR_NAME $WP_USR_MAIL --user_pass=$WP_USR_PWD --role=$WP_USR_ROLE --allow-root

fi

/usr/sbin/php-fpm7.3 --nodaemonize
