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
#      REVISION: 2016-11-02 13:55
#===============================================================================

set -o nounset                              # Treat unset variables as an error
set -e

e_header()   { echo -e "\e[35m\n$@\e[0m"; }
e_success()  { echo -e " \e[32m*\e[0m $@"; }
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
cpfile () {
   cp $name/${dotfile#.} ~/$dotfile
}

progs=(pvim ptmux pshell psol pgitlab pvmd)

pvim() {
name="vim"
dotfile=".vimrc"
dotdir="vim"

if [ "$@" = "install" ] ; then
   cpfile
   e_arrow2 "Cloning Vundle"
   gitclone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   e_arrow2 "Installing Plugins"
   vim +"set viewoptions=" +PluginInstall +qall
   e_arrow2 "Updating Template Files according to $CONFFILE"
   mkdir -p ~/.vim/templates/
   tfile="$HOME/.vim/templates/personal.template"
   cp ~/.vim/bundle/bash-support/bash-support/rc/personal.templates $tfile
   sed -i "s/^\(SetMacro( 'AUTHOR', *'\).*\('\)/\1$tauthor\2/" $tfile
   sed -i "s/^\(SetMacro( 'AUTHORREF', *'\).*\('\)/\1$tauthorref\2/" $tfile
   sed -i "s/^\(SetMacro( 'COMPANY', *'\).*\('\)/\1$tcompany\2/" $tfile
   sed -i "s/^\(SetMacro( 'COPYRIGHT', *'\).*\('\)/\1$tcopyright\2/" $tfile
   sed -i "s/^\(SetMacro( 'EMAIL', *'\).*\('\)/\1$temail\2/" $tfile
   sed -i "s/^\(SetMacro( 'LICENSE', *'\).*\('\)/\1$tlicense\2/" $tfile
   sed -i "s/^\(SetMacro( 'ORGANIZATION', *'\).*\('\)/\1$torganization\2/" $tfile
   sed -i "s/^\(SetFormat( 'DATE', *'\).*\('\)/\1$tdate\2/" $tfile
   sed -i "s/^\(SetFormat( 'TIME', *'\).*\('\)/\1$ttime\2/" $tfile
   sed -i "s/^\(SetFormat( 'YEAR', *'\).*\('\)/\1$tyear\2/" $tfile
fi

if [ "$@" = "update" ] ; then
   cpfile
   e_arrow2 "Updating Vundle"
   gitclone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   e_arrow2 "Removing unused Plugins"
   vim +"set viewoptions=" +PluginClean! +qall
   e_arrow2 "Installing new Plugins"
   vim +"set viewoptions=" +PluginInstall +qall
   e_arrow2 "Updating Template Files according to $CONFFILE"
   tfile="$HOME/.vim/templates/personal.template"
   mkdir -p ~/.vim/templates
   cp -u -p ~/.vim/bundle/bash-support/bash-support/rc/personal.templates $tfile
   sed -i "s/^\(SetMacro( 'AUTHOR', *'\).*\('\)/\1$tauthor\2/" $tfile
   sed -i "s/^\(SetMacro( 'AUTHORREF', *'\).*\('\)/\1$tauthorref\2/" $tfile
   sed -i "s/^\(SetMacro( 'COMPANY', *'\).*\('\)/\1$tcompany\2/" $tfile
   sed -i "s/^\(SetMacro( 'COPYRIGHT', *'\).*\('\)/\1$tcopyright\2/" $tfile
   sed -i "s/^\(SetMacro( 'EMAIL', *'\).*\('\)/\1$temail\2/" $tfile
   sed -i "s/^\(SetMacro( 'LICENSE', *'\).*\('\)/\1$tlicense\2/" $tfile
   sed -i "s/^\(SetMacro( 'ORGANIZATION', *'\).*\('\)/\1$torganization\2/" $tfile
   sed -i "s/^\(SetFormat( 'DATE', *'\).*\('\)/\1$tdate\2/" $tfile
   sed -i "s/^\(SetFormat( 'TIME', *'\).*\('\)/\1$ttime\2/" $tfile
   sed -i "s/^\(SetFormat( 'YEAR', *'\).*\('\)/\1$tyear\2/" $tfile
fi
}

ptmux() {
name="tmux"
dotfile=".tmux.conf"
dotdir="tmux"
if [ "$@" = "install" ] ; then
   cpfile
   e_arrow2 "clone tmux-plugins"
   gitclone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   e_arrow2 "Installing Plugins"
   tmux start-server
   tmux new-session -d
   ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

if [ "$@" = "update" ] ; then
   cpfile
   e_arrow2 "update tmux-plugins"
   gitclone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   e_arrow2 "Removing unused Plugins"
   tmux start-server
   tmux new-session -d
   ~/.tmux/plugins/tpm/scripts/clean_plugins.sh
   e_arrow2 "Updating Plugins"
   ~/.tmux/plugins/tpm/scripts/update_plugin.sh
fi

}

pshell() {
name="shell"
dotfile=".shellrc"
dotdir="shell"
if [ "$@" = "install" ] ; then
   rc=${SHELL#*/bin/}rc
   src="source ~/$dotfile"
   cpfile
   if grep -xq "^source ~/.shellrc" ~/.$rc
   then
      e_warn "$dotfile is already sourced in $rc. Adding nothing to $rc"
   else
      e_arrow2 "adding to $rc"
      echo $src >> ~/.$rc
   fi
   mkdir -p ~/.$dotdir
   e_arrow2 "downloading git-prompt/completion"
   wget  -N -P ~/.$name/ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
   wget  -N -P ~/.$name/ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
   wget  -N -O ~/.$name/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi

if [ "$@" = "update" ] ; then
   rc=${SHELL#*/bin/}rc
   src="source ~/$dotfile"
   cpfile
   if grep -xq "^source ~/.shellrc" ~/.$rc
   then
      e_arrow2 "$dotfile is already sourced in $rc. Adding nothing to $rc"
   else
      e_arrow2 "adding to $rc"
      echo $src >> ~/.$rc
   fi
   mkdir -p ~/.$dotdir
   e_arrow2 "downloading git-prompt/completion"
   wget -N -P ~/.$name/ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
   wget -N -P ~/.$name/ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
   wget -N -O ~/.$name/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi
}

psol() {
name="sol"
dotfile=".solrc"
dotdir="sol"
if [ "$@" = "install" ] ; then
   cpfile
   mkdir -p ~/.$dotdir
   cp -r $name/colors ~/.sol/
   e_arrow2 "clone dircolors"
   gitclone https://github.com/seebi/dircolors-solarized ~/.sol/dircolors
   e_arrow2 "Updating Template Files according to $CONFFILE"
   sed -i "s/tsolarizecolor/$tsolarizecolor/g" ~/$dotfile
fi

if [ "$@" = "update" ] ; then
   cpfile
   mkdir -p ~/.$dotdir
   cp -r $name/colors ~/.sol/
   e_arrow2 "update dircolors"
   gitclone https://github.com/seebi/dircolors-solarized ~/.sol/dircolors
   e_arrow2 "Updating Template Files according to $CONFFILE"
   sed -i "s/tsolarizecolor/$tsolarizecolor/g" ~/$dotfile
fi
}

pgitlab() {
name="gitlab"
dotfile=".python-gitlab.cfg"
dotdir=""

if [ "$@" = "install" ] ; then
   cpfile
   e_arrow2 "install python-gitlab"
   pip install --user --upgrade python-gitlab
   e_arrow2 "Updating Template Files according to $CONFFILE"
   sed -i "s/skelplace/$tgitlabname/g" ~/$dotfile
   sed -i "s|skelurl|$tgitlaburl|g" ~/$dotfile
   sed -i "s/skeltoken/$tgitlabtoken/g" ~/$dotfile
fi

if [ "$@" = "update" ] ; then
   cpfile
   e_arrow2 "install python-gitlab"
   pip install --user --upgrade python-gitlab
   e_arrow2 "Updating Template Files according to $CONFFILE"
   sed -i "s/skelplace/$tgitlabname/g" ~/$dotfile
   sed -i "s|skelurl|$tgitlaburl|g" ~/$dotfile
   sed -i "s/skeltoken/$tgitlabtoken/g" ~/$dotfile
fi
}

pvmd() {
name="vmd"
dotfile=".vmdrc"
if [[ "$OSTYPE" == "cygwin" ]]; then
   dotfile="vmd.rc"
fi
dotdir="vmd"
if [ "$@" = "install" ] ; then
   if [[ "$OSTYPE" == "cygwin" ]]; then
      cp $dotdir/vmdrc ~/$dotfile
   else
      cpfile
   fi
fi

if [ "$@" = "update" ] ; then
   if [[ "$OSTYPE" == "cygwin" ]]; then
      cp $dotdir/vmdrc ~/$dotfile
   else
      cpfile
   fi
fi

}

install() {
   check_config
   backup_dotfiles org
   remove_dotfiles
   do_dotfiles install
   e_success "pdot successfully installed! Please login again."
}

update() {
   update_git
   check_config
   backup_dotfiles old
   do_dotfiles update
   e_success "pdot successfully updated"
}

uninstall() {
   remove_dotfiles
   unbackup_dotfiles
   e_success "pdot successfully uninstalled"
}

update_git() {
   e_header "Updating pdot repository"
   git fetch
   UPSTREAM=${1:-'@{u}'}
   LOCAL=$(git rev-parse @{0})
   REMOTE=$(git rev-parse "$UPSTREAM")
   BASE=$(git merge-base @{0} "$UPSTREAM")
   if [ $LOCAL = $REMOTE ]; then
          echo "Up-to-date"
   elif [ $LOCAL = $BASE ]; then
       echo "Need to pull"
       ScriptLoc=$(readlink -f "$0")
       git pull
       exec $ScriptLoc $mode
       exit 1
   fi
}
check_config() {
   e_header "Checking if configure script was run..."
   if [ ! -e "$CONFFILE" ]; then
      e_error "$CONFFILE does not exist. Please run configure script ($CONFSCRIPT)"
   fi
   if [ "$CONFSCRIPT" -nt "$CONFFILE" ]; then
      e_error "$CONFFILE is older than configure script ($CONFSCRIPT). Please run configure script again."
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
      if [ -e "$HOME/$dotfile" ] ; then
         cp $HOME/$dotfile $BACKUP/
         e_success "Backed up $dotfile"
      fi
   done
   e_success "Backed up everything"
}

unbackup_dotfiles() {
   e_header "Restoring dotfiles"
   BACKUP="$BACKDIR-org/"
   e_arrow "Restoring from $BACKUP"
   for i in "${!progs[@]}"; do
      ${progs[$i]} dotfile
      if [ -e "$BACKUP/$dotfile" ] ; then
         cp $BACKUP/$dotfile $HOME/
         e_success "restored original $dotfile"
      fi
   done
   e_success "Restored everything"
}

remove_dotfiles() {
   e_header "Removing old dotfiles"
   for i in "${!progs[@]}"; do
      ${progs[$i]} dotfile
      rm -f ~/$dotfile
      e_success "removed ~/$dotfile"
      if [ ! "$dotdir" = "" ] ; then
	 rm -rf ~/.$dotdir
         e_success "removed ~/.$dotdir"
      fi
   done
   e_success "Removed all dotfiles"
}

do_dotfiles() {
   e_header "$@ Dotfiles"
   for i in "${!progs[@]}"; do
      ${progs[$i]} name
      e_arrow "$@ $name"
      ${progs[$i]} $@
      e_success "done with $name"
   done
   e_success "finished $@"
}

helpmessage() {
   e_header "Usage"
   echo "install.sh [install|update|uninstall]"
   exit 1
}
if [ $# -eq 0 ]; then
    helpmessage
fi
mode=$1
if [ $# -gt 1 ]; then
   progs=()
   for item in ${@:2}; do
      progs+=("p$item")
   done
   echo ${progs[@]}
fi
if [[ $mode == "install" ]]; then
  install
elif [[ $mode == "update" ]]; then
  update
elif [[ $mode == "uninstall" ]]; then
  uninstall
else
   helpmessage
fi
