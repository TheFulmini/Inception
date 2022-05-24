FROM debian:buster

RUN apt-get upgradet && apt-get update -y
RUN apt-get install vim tar php-fpm php-mysql -y
RUN mkdir -p /run/php/

ADD https://wordpress.org/latest.tar.gz /tmp/latest.tar.gz
RUN cd /tmp && tar xzvf latest.tar.gz && \
	rm -rf latest.tar.gz && \
	mkdir -p /var/www && mv -f wordpress /var/www/ && \
	chmod 775 -R /var/www/wordpress && \
	chown -R www-data:www-data /var/www/wordpress && \
	sed -i 's/listen =.*/listen = 9000' /etc/php/7.3/fpm/pool.d/www.conf

RUN rm -rf /var/www/wordpress/wp-config-sample.php
COPY src/wp-config-.php /var/www/wordpress/.
COPY src/run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

EXPOSE 9000

ENTRYPOINT [ "./tmp/run.sh"]
