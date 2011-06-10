#!/bin/sh
# Back ups the entire database on demand
#
# Cron entry
# 35 17 * * * /usr/bin/database-backup-all
#
# usage
# /usr/bin/database-backup-all

MYSQLDUMP="/opt/lampp/bin/mysqldump --routine -uusername -ppassword";
DUMPTO="/home/database-dumps/all";
DATADIR="/opt/lampp/var/mysql";

# Suffix to database name
STAMP=` date '+%m%d'`;

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