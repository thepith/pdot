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
if [[ -e ~/.vimrc ]]; then
   if ! cmp -s ~/.vimrc vimrc ; then
      echo ".vimrc exists already. Please remove before installing new vimrc"
      exit 1
   fi
else
   cp vimrc ~/.vimrc
fi

curdir=$PWD
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
cd $curdir

#install plugins
vim +"set viewoptions=" +PluginInstall +qall

#it is required to edit the template files of bash-supprot and awk-support
tfiles=( ~/.vim/bundle/bash-support.vim/bash-support/templates/Templates ~/.vim/bundle/awk-support.vim/awk-support/templates/Templates )

source ../pdot.conf

for f in ${tfiles[@]}; do 
   sed -i "s/^\(SetMacro( 'AUTHOR', *'\).*\('\)/\1$tauthor\2/" $f
   sed -i "s/^\(SetMacro( 'AUTHORREF', *'\).*\('\)/\1$tauthorref\2/" $f
   sed -i "s/^\(SetMacro( 'COMPANY', *'\).*\('\)/\1$tcompany\2/" $f
   sed -i "s/^\(SetMacro( 'COPYRIGHT', *'\).*\('\)/\1$tcopyright\2/" $f
   sed -i "s/^\(SetMacro( 'EMAIL', *'\).*\('\)/\1$temail\2/" $f
   sed -i "s/^\(SetMacro( 'LICENSE', *'\).*\('\)/\1$tlicense\2/" $f
   sed -i "s/^\(SetMacro( 'ORGANIZATION', *'\).*\('\)/\1$torganization\2/" $f
   sed -i "s/^\(SetFormat( 'DATE', *'\).*\('\)/\1$tdate\2/" $f
   sed -i "s/^\(SetFormat( 'TIME', *'\).*\('\)/\1$ttime\2/" $f
   sed -i "s/^\(SetFormat( 'YEAR', *'\).*\('\)/\1$tyear\2/" $f
done