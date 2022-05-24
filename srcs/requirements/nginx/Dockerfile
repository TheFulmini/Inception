FROM debian:buster

# install packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install nginx openssl -y

# certificate creation and right attribution
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -subj "/C=BE/ST=Brussels/L=Brussels/O=S19/OU=afulmini/CN=afulmini" \
        -out /etc/ssl/certs/afulmini.crt \
        -keyout /etc/ssl/certs/afulmini.key

# configuration nginx available and enabled sites
COPY ./src/nginx.conf /etc/nginx/sites-available/.

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

