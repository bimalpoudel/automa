#!/bin/bash
# Creates a system wide alias for accessing PHP

echo "/opt/lampp/bin/php \"\$@\"" > /usr/bin/php
chmod 755 /usr/bin/php
