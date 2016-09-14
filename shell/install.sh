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

#configure setup of solrc
confile=shellrc
rc=${SHELL#*/bin/}rc
src="source ~/.$confile"

if grep -xq "source ~/.shellrc" ~/.$rc
then
   echo "$confile is already sourced in $rc. Adding nothing to $rc"
else
   echo "adding to $rc"
   echo $src >> ~/.$rc
fi

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

mkdir -p ~/.shell
wget -P ~/.shell/ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
wget -P ~/.shell/ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
wget -P ~/.shell/ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
