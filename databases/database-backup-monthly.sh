#!/bin/sh
# Keeps a daily snapshot of othe database for a month.
# Maximum last 30 day databases are possible.
# Recycles the databases every month.
#
# Cron entry
# 55 16 * * * /usr/bin/database-backup-monthly
#
# usage
# /usr/bin/database-backup-monthly

MYSQLDUMP="/opt/lampp/bin/mysqldump -uusername -ppassword";
DUMPTO="/home/database-dumps/monthly";
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
    ${MYSQLDUMP} ${DATABASE} > ${DUMPTO}/${DATABASE}-${STAMP}.dmp
  fi
done;