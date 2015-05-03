Help super administrator set up an intranet server. This is particularly useful in web projects. Please note that different linux OS might behave differently with these scripts and produce unpredictable results.

So,be careful that you will run the corresponding scripts.
Run centos scripts on centos only.
Run ubuntu scripts on ubuntu only.

## Some commands ##
Please checkout how to use these files.

### /home/skeleton.sh [username](username.md) ###

This creates a linux user.
A mysql database, user and assigns permissions.
Registers the user into Mantis.
Creates an intranet blog account.

### /home/projects.sh [username](username.md) [projectname](projectname.md) ###
This creates a SVN repository for the existing user.
And assigns permissions.