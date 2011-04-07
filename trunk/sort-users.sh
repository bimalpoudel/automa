#!/bin/bash
# Sorts the entries in passwd and shadow files.
# Helpful in manually edting the passwd and shadow files.
# Do not use it unless you know what you are doing.
# Usage
#   /bin/bash sort-users.sh

# sort passwd file
cat /etc/passwd | sort > /tmp/passwd
cat /tmp/passwd > /etc/passwd
rm -f /tmp/passwd

# sort shadow file
cat /etc/shadow | sort > /tmp/shadow
cat /tmp/shadow > /etc/shadow
rm -f /tmp/shadow

# sort group file
cat /etc/group | sort > /tmp/group
cat /tmp/group > /etc/group
rm -f /tmp/group