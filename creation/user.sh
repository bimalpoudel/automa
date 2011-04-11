#!/bin/bash
# Creates a new user, FTP/SSH, MySQL database, Mantis User, WP user
# Usage:
# sh skeleton.sh USERNAME
# user USERNAME

# Only root may execute these commands
if [ "$(whoami)" != 'root' ]; then
  echo "Login as root to run this command: $0\n";
  exit 1;
fi;

# parameter should contain a new username
# todo: Check if the username exists already
# todo: Length should be less than 2-9 characters
if [ "$#" != "1" ]; then
  echo -e "Usage:\n\t$0 USERNAME\n";
  exit 1;
fi;

# Define a username here or take from user input parameter
USERNAME="$1";

# Username should be a valid datatype (for safety reasons)
if expr "${USERNAME}" : '[^a-z0-9]' > /dev/null; then
  echo -e "Username should be alphanumeric only.\n";
  exit 1; 
fi;

# Make sure that the username does not exist already
# USEREXISTS: 0, 1, ...?
USEREXISTS=`grep "^${USERNAME}:" /etc/passwd | wc -l`;
if [ "${USEREXISTS}" != "0" ]; then
  echo -e "This username exists already. Choose a different name.\n";
  exit 1;
fi;

# Generate server related parameters.
# Admin can change them at any time of business.
MYSQLROOT="root"; # Which user is allowed to administer the database?
MYSQLPASSWORD="toor";
SERVERNAME="192.168.1.104"; # IP or FQDN only - Useful in IP restrictions, ...
DATABASEPREFIX="cn";
COMPANY="/home/company";

# Generate user specific parameters.
# All users will have common pattern.
HOME="${COMPANY}/users/${USERNAME}";
HTDOCS="${COMPANY}/htdocs/users/${USERNAME}";
PUBLICHTML="${HOME}/public_html"; # Without the slash
INDEX=${PUBLICHTML}/index.php
SVN="${HOME}/svn";
BASHRC="${HOME}/.bashrc";
PASSWORD="`echo $RANDOM|md5sum|md5sum`"; PASSWORD=${PASSWORD:3:8};
MYSQL="/opt/lampp/bin/mysql -u${MYSQLROOT} -p${MYSQLPASSWORD} -e";
DATABASE="${DATABASEPREFIX}_${USERNAME}";
DATE=`date '+%Y%m%d%H%M%S'`;

# Make the user directories first
mkdir -p "${COMPANY}";
mkdir -p "${HOME}";
mkdir -p "${SVN}";
mkdir -p "${PUBLICHTML}";

# Link the Public HTML inside company's HTDOCS
ln -s ${PUBLICHTML} ${HTDOCS}

# Create the user
useradd --no-create-home --home-dir ${HOME} --password `mkpasswd ${PASSWORD}` --shell /bin/bash ${USERNAME}

# Make the alias and first time run scripts
echo \# Scripts for ${USERNAME} > ${BASHRC}
echo alias php=/opt/lampp/bin/php >> ${BASHRC}
echo alias mysql=/opt/lampp/bin/mysql >> ${BASHRC}
echo alias mysqldump=/opt/lampp/bin/mysqldump >> ${BASHRC}

# Make the database and assign the password
# It is risky to drop a database
# ${MYSQL} "DROP DATABASE IF EXISTS ${DATABASE};";
${MYSQL} "CREATE DATABASE IF NOT EXISTS ${DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;";
${MYSQL} "ALTER DATABASE ${DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;";
${MYSQL} "GRANT ALL ON ${DATABASE}.* TO '${USERNAME}'@'%' IDENTIFIED BY '${PASSWORD}';";
${MYSQL} "GRANT ALL ON ${DATABASE}.* TO '${USERNAME}'@'${SERVERNAME}' IDENTIFIED BY '${PASSWORD}';";
${MYSQL} "GRANT ALL ON ${DATABASE}.* TO '${USERNAME}'@'localhost' IDENTIFIED BY '${PASSWORD}';";
${MYSQL} "FLUSH PRIVILEGES;";

# MySQL connection test
MYSQLSCRIPT=${PUBLICHTML}/mysql.php
echo \<\?php > ${MYSQLSCRIPT}
echo error_reporting\(E_ALL\|E_STRICT\)\; >> ${MYSQLSCRIPT}
echo mysql_connect\(\'localhost\', \'${USERNAME}\', \'${PASSWORD}\'\)\; >> ${MYSQLSCRIPT}
echo mysql_select_db\(\'${DATABASE}\'\)\; >> ${MYSQLSCRIPT}
echo \?\> >> ${MYSQLSCRIPT}
echo If you did not see errors above, you are connected to mysql\. >> ${MYSQLSCRIPT}

# Create the index.php for the user
echo \<html xmlns="http://www.w3.org/1999/xhtml"\> > ${INDEX}
echo \<head\> >> ${INDEX}
echo \<meta http-equiv="Content-Type" content="text/html; charset=utf-8" \/\> >> ${INDEX}
echo \<title\>${USERNAME}\<\/title\> >> ${INDEX}
echo \</head\> >> ${INDEX}
echo \<body\> >> ${INDEX}
echo \<p\>Hello \<strong\>${USERNAME}\<\/strong\>\!, your website works.\<\/p\> >> ${INDEX}
echo \</body\> >> ${INDEX}
echo \<\/html\> >> ${INDEX}


# Store the passwords in a log file and give the file to the user
LOGFILE=${HOME}/${USERNAME}.txt
echo \# Log for ${USERNAME} > ${LOGFILE}
echo MySQL password\: ${PASSWORD} >> ${LOGFILE}
echo alias mysql=/opt/lampp/bin/mysql >> ${LOGFILE}
echo mysql -h${SERVERNAME} -u${USERNAME} -p${PASSWORD} ${DATABASE} >> ${LOGFILE}
echo FTP/SSH: ${USERNAME}:${PASSWORD}@${SERVERNAME} >> ${LOGFILE}
echo HTDOCS: ${HTDOCS}/ >> ${LOGFILE}
echo Created on ${DATE} >> ${LOGFILE}

# Log the users being created
echo "${DATE} ${USERNAME} : ${PASSWORD}" >> ${COMPANY}/users.txt

# Show a friendly message
echo Thank you!
echo Please check ${HOME}/${USERNAME}.txt for details.

chmod -R 1700 ${HOME}/
chmod -R 755 ${BASHRC}
chmod -R 700 ${HTDOCS}/

# A user's default group might have been modified.
chown -R ${USERNAME}:${USERNAME} ${HOME}
chown -R ${USERNAME}:${USERNAME} ${PUBLICHTML}
chown -R ${USERNAME}:${USERNAME} ${HTDOCS}
