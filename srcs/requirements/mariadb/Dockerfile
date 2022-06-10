FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y mariadb-server

# install mariadb-server

COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d

COPY tools/entrypoint.sh ./

# script used to configure mariadb-server, create wordpress database and run mariadb-server in foreground

EXPOSE 3306

ENTRYPOINT ["./entrypoint.sh"]