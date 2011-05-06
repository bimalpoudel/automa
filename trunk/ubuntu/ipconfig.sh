#!/bin/bash
# Pernamanent ipconfig, instead of ifconfig: use once once
# Helps in misspelt typing, while switching from Windows to Linux

ln -s $(which ifconfig) /usr/bin/ipconfig