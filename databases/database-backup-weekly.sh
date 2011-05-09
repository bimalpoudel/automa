#!/bin/sh
# Keeps a daily snapshot of othe database for a week.
# Maximum last 7 day databases are possible.
# Recycles the databases every week.
#
# Cron entry
# 30 12 * * * /usr/bin/database-backup-weekly
#
# usage
# /usr/bin/database-backup-weekly

MYSQLDUMP="/opt/lampp/bin/mysqldump -uusername -ppassword";
DUMPTO="/home/database-dumps/weekly";
DATADIR="/opt/lampp/var/mysql";

# Suffix to database name
STAMP=`date '+%A'|tr "[:upper:]" "[:lower:]"`;

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