#!/bin/sh
# Usage: database username databasename
# To Do: Remove the IDENTIFIED BY portion
# To Do: Use create user first, then grant.

PREFIX="prefix_";
USERNAME="$1";
DATABASE="${PREFIX}$2";

# Generate two different passwords for local and remote (%) use
PASSWORDL=$(echo $RANDOM|md5sum); PASSWORDL=${PASSWORDL:2:9};
PASSWORDR=$(echo $RANDOM|md5sum); PASSWORDR=${PASSWORDR:2:9};

# What log file to produce?
DBSCRIPTS="/tmp/database-${DATABASE}.log";

echo \#Do not drop existing database > ${DBSCRIPTS};
echo \#DROP DATABASE IF EXISTS \`${DATABASE}\`\; >> ${DBSCRIPTS};
echo CREATE DATABASE \`${DATABASE}\` CHARACTER SET utf8 COLLATE utf8_general_ci\; >> ${DBSCRIPTS};
echo GRANT ALL ON \`${DATABASE}\`.* TO \'${USERNAME}\'@\'localhost\' IDENTIFIED BY \'${PASSWORDL}\'\; >> ${DBSCRIPTS};
echo GRANT ALL ON \`${DATABASE}\`.* TO \'${USERNAME}\'@\'%\' IDENTIFIED BY \'${PASSWORDR}\'\; >> ${DBSCRIPTS};
echo FLUSH PRIVILEGES\; >> ${DBSCRIPTS};
cat ${DBSCRIPTS};

/opt/lampp/bin/mysql -uroot -ptoor < ${DBSCRIPTS};