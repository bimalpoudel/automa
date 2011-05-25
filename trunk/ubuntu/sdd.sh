#!/bin/sh
# Lists all the possible disks to mount

# /bin/ls -1 /dev/sd*

echo "/bin/ls -1 /dev/sd*|grep -e '[0-9]\$'" > /usr/bin/sdd
chmod 755 /usr/bin/sdd