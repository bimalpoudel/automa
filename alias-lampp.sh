#!/bin/bash
# Creates a system wide alias for accessing LAMPP

echo "/opt/lampp/lampp \"\$@\"" > /usr/bin/lampp
chmod 755 /usr/bin/lampp