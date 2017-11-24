#!/bin/bash

FORCE="$1"
SYNTAX="$2"
EXTENSION="$3"
OUTPUTDIR="$4"
INPUT="$5"
CSSFILE="$6"

FILE=$(basename "$INPUT")
FILENAME=$(basename "$INPUT" .$EXTENSION)
FILEPATH=${INPUT%$FILE}
OUTDIR=${OUTPUTDIR%$FILEPATH*}
OUTPUT="$OUTDIR"/$FILENAME
CSSFILENAME=$(basename "$6")

MATH="--mathml"

unameOut="$(uname -s)"
case "${unameOut}" in
    CYGWIN*)
       ieee=`cygpath -wa ~/.vim/vimwiki_pandoc/ieee-with-url.csl`
       bib=`cygpath -wa ~/literature/bib.bib`
       ;;
    *)
       ieee=~/.vim/vimwiki_pandoc/ieee-with-url.csl
       bib=~/literature/bib.bib
       ;;
esac

# >&2 echo "MATH: $MATH"
HEADING=${FILE%.md}
sed -r 's/(\[.+\])\(([^)]+)\)/\1(\2.html)/g' <"$INPUT" | pandoc $MATH -s -f $SYNTAX --filter pandoc-citeproc --csl $ieee --bibliography $bib -t html -c $CSSFILENAME --metadata pagetitle="$HEADING" | sed -r 's/<li>(.*)\[ \]/<li class="done0">\1/g; s/<li>(.*)\[X\]/<li class="done4">\1/g; s/<li>(.*)\[S\]/<li class="done2">\1/g' >"$OUTPUT.html"
