#!/bin/bash
# alias: /usr/bin/backup
# Recurse and backup all possible databases directly from the data directories
# Change correct username and password
# Indented to run for automated backups via cron scripts
#
# usage
# /user/bin/backup

MYSQLDUMP="/opt/lampp/bin/mysqldump -uusername -ppassword";
DUMPTO="/home/database-dumps/all";
DATADIR="/opt/lampp/var/mysql";

# Just be sure that the dump location exists
mkdir -p "${DUMPTO}";

# loop through the data directories
# and take individual backups
# assume each directory name as a database name
for DATABASE in `ls ${DATADIR}`
do
  if [ -d "${DATADIR}/${DATABASE}" ]; then
    ${MYSQLDUMP} ${DATABASE} > ${DUMPTO}/${DATABASE}.dmp
  fi
done;