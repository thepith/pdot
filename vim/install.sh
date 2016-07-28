#!/bin/bash - 
#===============================================================================
#
#          FILE: install.sh
# 
#         USAGE: ./install.sh 
# 
#   DESCRIPTION: installs vimrc and downloads additional plugins
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
command -v vim >/dev/null 2>&1 || { echo >&2 "I require vim but it's not installed.  Aborting."; exit 1; }

if [[ -e ~/.vimrc ]]; then
   if ! cmp -s ~/.vimrc vimrc ; then
      echo ".vimrc exists already. Please remove before installing new vimrc"
      exit 1
   fi
else
   cp vimrc ~/.vimrc
fi

#get vundle
REPOSRC=https://github.com/VundleVim/Vundle.vim.git 
LOCALREPO=~/.vim/bundle/Vundle.vim
# We do it this way so that we can abstract if from just git later on
LOCALREPO_VC_DIR=$LOCALREPO/.git

if [ ! -d $LOCALREPO_VC_DIR ]
then
git clone $REPOSRC $LOCALREPO
else
cd $LOCALREPO
git pull $REPOSRC
fi

#install plugins
vim +"set viewoptions=" +PluginInstall +qall

#it is required to edit the template files of bash-supprot and awk-support
read -e -p "Modify the vim template files of bash-support and awk-support? (y/n)" -i "n" dotemp
case ${answer:0:1} in
    y|Y )
      vim -p ~/.vim/bundle/bash-support.vim/bash-support/templates/Templates ~/.vim/bundle/awk-support.vim/awk-support/templates/Templates
    ;;
    * )
        echo "keeping template files as they are"
    ;;
esac

