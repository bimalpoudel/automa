#!/bin/bash
# Installs various links to standard applications
# These are different from run time aliases
# These changes are permanent and allow direct access

# from the XAMPP stack
ln -s /opt/lampp/lampp /usr/bin/lampp
ln -s /opt/lampp/bin/php /usr/bin/php
ln -s /opt/lampp/bin/mysql /usr/bin/mysql
ln -s /opt/lampp/bin/mysqldump /usr/bin/mysqldump
ln -s /opt/lampp/htpasswd /usr/bin/htpasswd
ln -s /opt/lampp/sbin/proftpd /usr/bin/proftpd