#!/bin/bash - 
#===============================================================================
#
#          FILE: install.sh
# 
#         USAGE: ./install.sh 
# 
#   DESCRIPTION: installs python-gitlab and downloads additional plugins
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#       CREATED: 2016-07-27 17:00
#      REVISION: 2016-07-27 17:17
#===============================================================================

set -o nounset                              # Treat unset variables as an error
set -e                                      # Abort on error

#configure setup of vimrc
rcfile=python-gitlab.cfg
if [[ -e ~/.$rcfile ]]; then
   if ! cmp -s ~/.$rcfile $rcfile ; then
      echo ".$rcfile exists already. Please remove before installing new $rcfile"
      exit 1
   fi
else
   cp $rcfile ~/.$rcfile
fi

curdir=$PWD
pip install --user --upgrade python-gitlab

source ../pdot.conf

sed -i "s/skelplace/$tgitlabname/g" ~/.$rcfile
sed -i "s|skelurl|$tgitlaburl|g" ~/.$rcfile
sed -i "s/skeltoken/$tgitlabtoken/g" ~/.$rcfile
