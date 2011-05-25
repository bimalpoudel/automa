#!/bin/bash
# Lists out all the hard disks occupancy information
#
# Usage:
# hdd

echo "df --all -h" > /usr/bin/hdd
chmod 755 /usr/bin/hdd