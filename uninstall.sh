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
#       CREATED: 2016-07-27 16:45
#      REVISION: 2016-07-27 17:25
#===============================================================================

set -o nounset                              # Treat unset variables as an error
set -e                                      # Abort on error

progs=(vim tmux sol)
echo "This will delete all configuration files for the following programs:"
echo ${progs[@]}

read -e -p "Continure?" -i "" do

case ${do:0:1} in
    y|Y )
      for i in "${progs[@]}"; do
         echo "uninstalling $i"
         rm -rf ~/.$i*
      done
    ;;
    * )
        echo "not uninstalling"
    ;;
esac


