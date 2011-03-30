#!/bin/sh
# Creates additional databases for a user.
# Usage: database username databasename
# To Do: Remove the IDENTIFIED BY portion.
#    This is overwriting the old user password, affecting password change or project database connection failure.
# To Do: Create user first, then grant permissions.

# Which user is allowed to administer the database?
MYSQLROOT="root";
MYSQLPASSWORD="toor";
PREFIX="cn_";
DATE=`date '+%Y%m%d%H%M%S'`;

USERNAME="$1";
DATABASE="${PREFIX}$2";
PASSWORD=$(echo $RANDOM|md5sum); PASSWORD=${PASSWORD:2:9};

# What log file to produce?
DBSCRIPTS="/tmp/${DATABASE}.log";

echo \#DROP DATABASE IF EXISTS \`${DATABASE}\`\; > ${DBSCRIPTS};
echo CREATE DATABASE \`${DATABASE}\` CHARACTER SET utf8 COLLATE utf8_general_ci\; >> ${DBSCRIPTS};
echo GRANT ALL ON \`${DATABASE}\`.* TO \'${USERNAME}\'@\'localhost\' IDENTIFIED BY \'${PASSWORD}\'\; >> ${DBSCRIPTS};
echo GRANT ALL ON \`${DATABASE}\`.* TO \'${USERNAME}\'@\'%\' IDENTIFIED BY \'${PASSWORD}\'\; >> ${DBSCRIPTS};
echo FLUSH PRIVILEGES\; >> ${DBSCRIPTS};

/opt/lampp/bin/mysql -u${MYSQLROOT} -p${MYSQLPASSWORD} < ${DBSCRIPTS};

# Log the databases being created
echo "${DATE} ${USERNAME} : ${PASSWORD} : ${DATABASE}" >> ${COMPANY}/databases.txt