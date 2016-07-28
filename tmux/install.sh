#!/bin/bash - 
#===============================================================================
#
#          FILE: install.sh
# 
#         USAGE: ./install.sh 
# 
#   DESCRIPTION: installs tmux.conf and downloads additional plugins
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

confile="tmux.conf"
#configure setup of vimrc
if [[ -e ~/.$confile ]]; then
   if ! cmp -s ~/.$confile $confile ; then
      echo ".$confile exists already. Please remove before installing new .$confile"
      exit 1
   fi
   echo "$confile is up to date"
else
   cp $confile ~/.$confile
   echo "copying $confile"
fi

curdir=$PWD
#get vundle
REPOSRC=https://github.com/tmux-plugins/tpm
LOCALREPO=~/.tmux/plugins/tpm
# We do it this way so that we can abstract if from just git later on
LOCALREPO_VC_DIR=$LOCALREPO/.git

if [ ! -d $LOCALREPO_VC_DIR ]
then
git clone $REPOSRC $LOCALREPO
else
cd $LOCALREPO
git pull $REPOSRC
fi
cd $curdir
