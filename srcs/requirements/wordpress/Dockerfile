FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y curl

RUN apt-get install -y php7.3-fpm php7.3-common php7.3-mysql \
    php7.3-xml php7.3-xmlrpc php7.3-curl php7.3-gd \
    php7.3-imagick php7.3-cli php7.3-dev php7.3-imap \
    php7.3-mbstring php7.3-opcache php7.3-redis \
    php7.3-soap php7.3-zip -y

# command used to install PHP 7.3 and some php extensions

RUN apt-get install -y mariadb-client

# mariadb-client is used to communicate with mariadb server

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# to download wp-cli wich will be used to install wordpress

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# to use wp-cli.phar as wp

COPY tools/www.conf /etc/php/7.3/fpm/pool.d

# configuration file for php-fmp, it precises on wich port to listen to requests

RUN mkdir -p /run/php

# create the folder where the php7.3-fpm.pid will be stored

COPY tools/entrypoint.sh /

EXPOSE 9000

WORKDIR /var/www/html/wordpress

# current working directory inside the container

ENTRYPOINT ["/entrypoint.sh"]

# install and configure wordpress with wp-cli if it not installed yet
# start php-fpm in foreground, --nodaemonize bypass any conf file