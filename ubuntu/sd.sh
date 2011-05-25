#!/bin/sh
# Mounts a drive by parameter.

if [ "$#" != "1" ]; then
  echo -e "Usage:\n\t$0 XN\n";
  echo "X: Hard Disk Name (Alphabets like: b c d e f ...";
  echo "N: Partition Number (like 1 2 3 4 5 6 7 8 9 10 ..."
  exit 1;
fi;

DRIVENAME="$1";

mkdir -p /mnt/sd${DRIVENAME};
mount /dev/sd${DRIVENAME} /mnt/sd${DRIVENAME};