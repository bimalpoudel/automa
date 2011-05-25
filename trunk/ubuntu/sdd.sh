#!/bin/sh
# Lists all the possible disks to mount

# /bin/ls -1 /dev/sd*

echo "/bin/ls -1 /dev/sd*" > /usr/bin/sdd
chmod 755 /usr/bin/sdd