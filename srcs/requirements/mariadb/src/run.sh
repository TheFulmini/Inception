if [ -d "/run/mysql" ]; then
	echo "mysql already installed"
	chown -R mysql:mysql /run/mysqld
else
	echo "mysql not found, intalling now..."
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
	echo "MySQL directory already exists."
	chown -R mysql:mysql /var/lib/mysql/mysql
else
	echo "MySQL directory not found, creating..."
	chown -R mysql:mysql /var/lib/mysql/mysql
	mysql_install_db --user=mysql --ldata=/var/lib/mysql
	tfile=$(mktemp)
	cat << EOF > $tfile
CREATE DATABASE IF NOT EXISTS $MYSLQ_DB;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON $MYSLQ_DB.* TO '$MYSQL_USR'@'%' IDENTIFIED BY '$MYSQL_PWD';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PWD';
FLUSH PRIVILEGES;
EOF

	mysqld -u mysql --bootstrap --skip-networking=0 < $tfile
	rm -f $tfile

fi
	mysqld -u mysql --skip-networking=0
 