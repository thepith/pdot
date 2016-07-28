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
   if [[ ! $(readlink -f ~/.vimrc) = $(readlink -f vimrc) ]]; then
      echo ".vimrc exists already. Please remove before installing new vimrc"
      exit 1
   fi
fi

ln -s ~/.vimrc vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

