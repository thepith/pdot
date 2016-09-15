#!/bin/bash - 
#===============================================================================
#
#          FILE: install.sh
# 
#         USAGE: ./install.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Pascal Hebbeker (PH), pascal.hebbeker@gmail.com
#  ORGANIZATION: 
#       CREATED: 2016-09-15 09:39
#      REVISION: 2016-09-15 11:30
#===============================================================================

set -o nounset                              # Treat unset variables as an error
set -e

e_header()   { echo -e "\e[35m\n$@\e[0m"; }
e_success()  { echo -e " \e[32m✓\e[0m $@"; }
e_error()    { echo -e " \e[31mx\e[0m $@"; exit 1 ; }
e_warn()    { echo -e " \e[31m!\e[0m $@"; }
e_arrow()    { echo -e " \e[33m>\e[0m $@"; }
e_arrow2()    { echo -e " \e[33m->\e[0m $@"; }
                                          
DOTHOME="$(dirname "$(cd "$(dirname "$0")" && pwd -P)")"
BACKDIR="$PWD/backup"
CONFFILE="pdot.conf"
CONFSCRIPT="configure.sh"

gitclone() {
curdir=$PWD
#get vundle
REPOSRC=$1
LOCALREPO=$2
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
}

#progs=(vim tmux shell sol gitlab)
progs=(pvim ptmux psol)

pvim() {
name="vim"
if [ "$@" = "dotfile" ] ; then
   dotfile="vimrc"
   dotdir="vim"
fi

if [ "$@" = "install" ] ; then
   e_arrow2 "cloning vundle"
   gitclone https://github.com/vundlevim/vundle.vim.git ~/.vim/bundle/vundle.vim
   e_arrow2 "installing plugins"
   vim +"set viewoptions=" +plugininstall +qall
   e_arrow2 "updating template files accoring to $conffile"
   tfiles=( ~/.vim/bundle/bash-support.vim/bash-support/templates/templates ~/.vim/bundle/awk-support.vim/awk-support/templates/templates )

   for f in ${tfiles[@]}; do 
      sed -i "s/^\(setmacro( 'author', *'\).*\('\)/\1$tauthor\2/" $f
      sed -i "s/^\(setmacro( 'authorref', *'\).*\('\)/\1$tauthorref\2/" $f
      sed -i "s/^\(setmacro( 'company', *'\).*\('\)/\1$tcompany\2/" $f
      sed -i "s/^\(setmacro( 'copyright', *'\).*\('\)/\1$tcopyright\2/" $f
      sed -i "s/^\(setmacro( 'email', *'\).*\('\)/\1$temail\2/" $f
      sed -i "s/^\(setmacro( 'license', *'\).*\('\)/\1$tlicense\2/" $f
      sed -i "s/^\(setmacro( 'organization', *'\).*\('\)/\1$torganization\2/" $f
      sed -i "s/^\(setformat( 'date', *'\).*\('\)/\1$tdate\2/" $f
      sed -i "s/^\(setformat( 'time', *'\).*\('\)/\1$ttime\2/" $f
      sed -i "s/^\(setformat( 'year', *'\).*\('\)/\1$tyear\2/" $f
   done
fi
}

ptmux() {
name="tmux"
if [ "$@" = "dotfile" ] ; then
   dotfile="tmux.conf"
   dotdir="tmux"
fi
}

psol() {
name="solarized-colors"
if [ "$@" = "dotfile" ] ; then
   dotfile="solrc"
   dotdir="sol"
fi
}

install() {
   check_config
   backup_dotfiles org
   remove_dotfiles
   install_dotfiles
   print_messages
}

update() {
   update_git
   check_config
   backup_dotfiles old
   update_dotfiles
   print_messages
}

uninstall() {
   remove_dotfiles
   unbackup_dotfiles_org
   print_messages
}

check_config() {
   e_header "Checking if configure script was run..."
   if [ ! -e "$CONFFILE" ]; then
      e_error "$CONFFILE does not exist. Please run configure script ($CONFSCRIPT)"
   fi
   if [ "$CONFSCRIPT" -nt "$CONFFILE" ]; then
      e_error "$CONFFILE is older than configure script ($CONFSCRIPT). Please rerun configure script."
   fi
   source pdot.conf
   e_success "Configuration stored in $CONFFILE was loaded"
}

backup_dotfiles() {
   e_header "Backing up old dotfiles"
   BACKUP="$BACKDIR-$@/"
   mkdir -p $BACKUP
   e_arrow "Backing up to $BACKUP"
   for i in "${!progs[@]}"; do
      ${progs[$i]} dotfile
      cp $HOME/.$dotfile $BACKUP/
      e_arrow2 "Backed up .$dotfile"
   done
   e_success "Backed up everything"
}

remove_dotfiles() {
   e_header "Removing old dotfiles"
   for i in "${!progs[@]}"; do
      ${progs[$i]} dotfile
      #rm -rf ~/.$dotdir
      #rm ~/.$dotfile
      e_arrow2 "removed ~/.$dotfile and ~/.$dotdir"
   done
   e_success "Removed all dotfiles"
}

install_dotfiles() {
   e_header "Installing Dotfiles"
   for i in "${!progs[@]}"; do
      ${progs[$i]}
      e_arrow "installing $name"
      ${progs[$i]} install
      e_success "installed $name"
   done
   e_success "Installed dotfiles"
}

(install)
