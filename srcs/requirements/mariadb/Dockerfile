FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y mariadb-server

COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d

COPY tools/entrypoint.sh ./

EXPOSE 3306

ENTRYPOINT ["./entrypoint.sh"]