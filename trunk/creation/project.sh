#!/bin/sh
# Creates an SVN repository under a user.
# And links it to the company's HTDOCS area.
# Usage:
# sh project.sh USERNAME PROJECTNAME
# user USERNAME

# Only root may execute these commands
if [ "$(whoami)" != 'root' ]; then
  echo "No permissions to run $0 as non-root user.";
  exit 1;
fi;

# Username and project name pameters
if [ "$#" != "2" ]; then
  echo -e "Usage:\n\t$0 USERNAME PROJECTNAME\n";
  exit 1;
fi;

USERNAME="$1";
PROJECTNAME="$2";

# Generate server related parameters.
COMPANY="/home/company";

# Generate user specific parameters.
HOME="${COMPANY}/users/${USERNAME}";
HTDOCS="${COMPANY}/htdocs/users/${USERNAME}";
PUBLICHTML="${HOME}/public_html"; # Without the slash
SVN="${HOME}/svn";
DATE=`date '+%Y%m%d%H%M%S'`;

# Repo directory should not exist already.
if [ ! -d "${SVN}/${PROJECTNAME}" ]; then
  mkdir -p "${SVN}";
  svnadmin create ${SVN}/${PROJECTNAME}
else
  echo 'Repository destination exists. Project creation failed.';
  exit;
fi;

# Make project HTDOCS area
PROJECTHTDOCS="${PUBLICHTML}/${PROJECTNAME}";
if [ ! -d "${PROJECTHTDOCS}" ]; then
  mkdir -p "${PROJECTHTDOCS}";
fi;
# And immediately check it out from the local file system
svn checkout --quiet file://${SVN}/${PROJECTNAME} ${PROJECTHTDOCS}/

# Create SVN Hooks
HOOK="${SVN}/${PROJECTNAME}/hooks/post-commit";
touch "${HOOK}";
chmod 755 "${HOOK}";

# Write the hook contents
echo \#\!/bin/sh > ${HOOK}
echo REPOS="\$1" >> ${HOOK}
echo REV="\$2" >> ${HOOK}
echo svn update --quiet ${HTDOCS} >> ${HOOK}

# Set the user permissions
chmod -R 755 ${PROJECTHTDOCS}
chmod -R 755 ${SVN}/${PROJECTNAME}

chown -R ${USERNAME}:${USERNAME} ${PROJECTHTDOCS}
chown -R ${USERNAME}:${USERNAME} ${SVN}/${PROJECTNAME}

# Log the SVN Projects being created
echo "${DATE} ${USERNAME} : ${PROJECTNAME} : ${SVN}/${PROJECTNAME} : ${PROJECTHTDOCS}" >> ${COMPANY}/projects.txt
echo "svn+ssh://${USERNAME}@116.66.194.122:2010${SVN}/${PROJECTNAME}" >> ${COMPANY}/checkouts.txt
