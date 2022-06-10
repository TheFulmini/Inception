FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y nginx
RUN apt-get install -y openssl

COPY tools/nginx.conf /etc/nginx/

# COPY the global nginx configuration file to our container

COPY tools/wordpress.conf /etc/nginx/sites-enabled

# COPY our wordpress website server configuration file to the container, this is included in the global nginx configuration file

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=BE/ST=Brussels/L=Brussels/O=19/CN=afulmini" \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt

# -req 				to specify we want to use -x509
# -x509 			to specify we want to create a self-signed certificate instead of generating a certificate signing request
# -nodes			to skip the option to secure our certificate with a passphrase, so nginx can read it
# -days				to specify the certifcate validity
# -newkey rsa:2048	to specify we want to generate both a new key and a new certificate with an RSA key of 2048 bits
# -subj				to specify subject without filling the prompt
# -keyout			to specify the location of the output 'nginx-selfsigned.key' file
# -out				to specify the location of the output 'nginx-selfsigned.crt' file

ENTRYPOINT ["nginx", "-g", "daemon off;"]

# -g "daemon off;"	to set global configuration "directives", will add line between quotes to nginx global configuration (nginx.conf)
# this command is used to launch nginx in the foreground in the container instead of the background as a daemon (by default).
# as a container is meant to only run one process we can run it in the foreground
# as a container terminate when there is no more processes running in the foreground using this command is the way to ensure our nginx container will not terminate right after being setup
# ENTRYPOINT works similarly to CMD but cannot be overridden by adding paramaters to a docker run command

EXPOSE 443

# used to inform that this container will provide service on port 443