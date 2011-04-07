#!/bin/bash
# Sorts the entries in passwd and shadow files.
# Helpful in manually edting the passwd and shadow files.
# Do not use it unless you know what you are doing.
# Usage
#   /bin/bash sort-users.sh

cat /etc/passwd|sort > /tmp/passwd
cat /tmp/passwd > /etc/passwd
rm -f /tmp/passwd

cat /etc/shadow | sort > /tmp/shadow
cat /tmp/shadow > /etc/shadow
rm -f /tmp/shadow
