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

echo "making and installing all Programs (configurations)"

progs=(vim)

mkdir -p bin

for i in "${progs[@]}"; do
   echo "installing ${!i}"
   cd ${!i}
   ./install.sh
   cd ../
done

