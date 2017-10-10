#!/bin/bash

if [ "x$1" == "x" ] ; then
	echo "Usage: $0 <refspec>"
	echo "    Will create texmf.<refspec>.zip in current directory."
	exit 1
fi

FILENAME="texmf.$1.zip"

git archive --format zip -o $FILENAME "$1"
