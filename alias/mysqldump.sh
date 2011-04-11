#!/bin/bash
# Creates a system wide alias for accessing MySQL Dump

echo "/opt/lampp/bin/mysqldump \"\$@\"" > /usr/bin/mysqldump
chmod 755 /usr/bin/mysqldump
