#!/bin/bash -
#===============================================================================
#
#          FILE: configure.sh
#
#         USAGE: ./configure.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 28/07/2016 09:09
#      REVISION: 2016-09-15 08:42
#===============================================================================

set -o nounset                              # Treat unset variables as an error

echo "checking dependencies"

progs=(vim tmux pip git wget)
for i in "${progs[@]}"; do
   echo -n "Checking $i ..."
   command -v $i >/dev/null 2>&1 || { echo >&2 "I require $i but it's not installed.  Aborting."; exit 1; }
   echo "done"
done

#creating pdot_secret.conf where user passwords are stored
echo "Warning, the passwords you enter here will be stored in plain text on your machine. Do not use sensible passwords"
# confvar=( tgitlabname tgitlaburl tgitlabtoken tSimpleNoteEmail tSimpleNotePassword)
confvar=()
confdef=( 'gitlab-name' 'https://some.whe.re' 'asdf1234' 'name@mail.com' '<secret>')
if [[ -e pdot_secret.conf ]]; then
   source pdot_secret.conf
fi
if [[ -e pdot.conf ]]; then
   # source pdot.conf for legacy reasons
   source pdot.conf
fi
for (( i=0; i<${#confvar[@]}; i++ )) ; do
   if [ ! -z ${!confvar[$i]+x} ] ; then
      confdef[$i]=${!confvar[$i]}
   fi
done
for (( i=0; i<${#confvar[@]}; i++ )) ; do
   read -r -e -p "${confvar[$i]#t}? " -i "${confdef[$i]}" ans
   confdef[$i]=$ans
done
for (( i=0; i<${#confvar[@]}; i++ )) ; do
   echo "${confvar[$i]}='"${confdef[$i]}"'"

done > pdot_secret.conf

#creating pdot.conf where user parameters are stored
confvar=( tsolarizecolor )
confdef=( 'dark' )
if [[ -e pdot.conf ]]; then
   source pdot.conf
fi
for (( i=0; i<${#confvar[@]}; i++ )) ; do
   if [ ! -z ${!confvar[$i]+x} ] ; then
      confdef[$i]=${!confvar[$i]}
   fi
done

for (( i=0; i<${#confvar[@]}; i++ )) ; do
   read -r -e -p "${confvar[$i]#t}? " -i "${confdef[$i]}" ans
   confdef[$i]=$ans
done
for (( i=0; i<${#confvar[@]}; i++ )) ; do
   echo "${confvar[$i]}='"${confdef[$i]}"'"

done > pdot.conf
