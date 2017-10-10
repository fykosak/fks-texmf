#!/bin/bash

#
# Use this script for deploying this texmf structure to your local texmf
# location.
#

TEXMF="$HOME/texmf/" # change this to your user texmf dir
dirs="
tex/latex/fykosx
tex/latex/geometry
metapost/fykos
fonts/truetype/fykos
tex/xelatex/xetex-def
"
LATEX="tex/latex/fykosx" # path to store fykosx macros

if [ -d "$TEXMF$LATEX" -a "$1" != "-f" ] ; then
	echo "Macros 'fykosx' already installed. Use -f to reinstall."
	exit 1
fi

# preapre directories
for dir in $dirs ; do
	rm -rf "$TEXMF$dir"
	mkdir -p "$TEXMF$dir"
	cp -r ./"$dir"/* -t "$TEXMF$dir"
done

# update kpathsearch
mktexlsr ${TEXMF:0:-1}
