FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y curl

RUN apt-get install -y php7.3-fpm php7.3-common php7.3-mysql \
    php7.3-xml php7.3-xmlrpc php7.3-curl php7.3-gd \
    php7.3-imagick php7.3-cli php7.3-dev php7.3-imap \
    php7.3-mbstring php7.3-opcache php7.3-redis \
    php7.3-soap php7.3-zip -y

RUN apt-get install -y mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/www.conf /etc/php/7.3/fpm/pool.d

RUN mkdir -p /run/php

COPY tools/entrypoint.sh /

EXPOSE 9000

WORKDIR /var/www/html/wordpress

ENTRYPOINT ["/entrypoint.sh"]