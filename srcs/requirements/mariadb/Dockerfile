FROM debian:buster

# install packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install mariadb mariadb-client mariadb-common

# copy config files
COPY src/wp_db.sql .
COPY src/afulmini.cnf /etc/.
COPY src/run.sh .

RUN chmod +x run.sh

EXPOSE 3306

CMD ./run.sh
