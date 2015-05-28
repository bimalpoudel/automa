#!/bin/bash
# Disallows users to login via SSH
echo "This accout is for ftp access only" > /bin/ftpaccess
echo "exit 0" >> /bin/ftpaccess
chmod +x /bin/ftpaccess

# Now, modify the default shell of the user to /bin/ftpaccess
# Notes: Read somewhere about this technique, but it does not
# work in Ubuntu.

# http://www.pc-freak.net/blog/enable-user-access-only-to-proftp-server-disable-user-login-via-ssh-scp-and-sftp/