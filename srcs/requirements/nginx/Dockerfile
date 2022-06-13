FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y nginx
RUN apt-get install -y openssl

COPY tools/nginx.conf /etc/nginx/
COPY tools/wordpress.conf /etc/nginx/sites-enabled

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=BE/ST=Brussels/L=Brussels/O=19/CN=afulmini" \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt

ENTRYPOINT ["nginx", "-g", "daemon off;"]

EXPOSE 443
