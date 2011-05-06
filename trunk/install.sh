#!/bin/bash
# Creates all necessary directories for smooth operation
# You may have to reconfigure specific services
#   like, mysql database area
#   like, apache htdocs area

# The home - real home
# It can reside anywhere, even in a different partition
mkdir -p /home/company/

# database storage area
mkdir /home/company/database

# apache htdocs area to host websites
# htdocs/<user>/<project>
mkdir /home/company/htdocs

# the major svn repository
# individual users can have their own svn directories
# but this acts as a link to all of them
mkdir /home/company/svn

# all files under control of users reside here
# including their home, htdocs and svn
mkdir /home/company/users

# optional backup zone
mkdir /home/company/backup