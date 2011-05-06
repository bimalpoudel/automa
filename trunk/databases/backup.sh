#!/bin/bash
# alias: /usr/bin/backup
# Recurse and backup all possible databases directly from the data directories

MYSQLDUMP="/opt/lampp/bin/mysqldump -uusername -ppassword";
DUMPTO="/home/database-dumps/all";
DATADIR="/opt/lampp/var/mysql";

# Just be sure that the dump location exists
mkdir -p "${DUMPTO}";

for DATABASE in `ls ${DATADIR}`
do
  if [ -d "${DATADIR}/${DATABASE}" ]; then
    ${MYSQLDUMP} ${DATABASE} > ${DUMPTO}/${DATABASE}.dmp
  fi
done;