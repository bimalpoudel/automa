#!/bin/bash
# Creates a system wide alias for accessing proftpd

echo "/opt/lampp/sbin/proftpd \"\$@\"" > /usr/bin/proftpd
chmod 755 /usr/bin/proftpd