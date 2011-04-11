#!/bin/bash
# Creates a system wide alias for accessing mysql

echo "/opt/lampp/bin/mysql \"\$@\"" > /usr/bin/mysql
chmod 755 /usr/bin/mysql
