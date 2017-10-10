#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

. $SCRIPTPATH/functions.sh

function usage {
	echo "Usage: $0 [-v] <texmf> <test file> <outdir>"
	exit 0
}

if [ "x$3" = "x" ] ; then
	usage
fi

if [ "$1" = "-v" ] ; then
	log_init $LOG_VERBOSE
	verb=-v
	VERBOSE=1
	shift
else
	log_init $LOG_ERROR
fi

TEXMF="$1"
FILE="$2"
OUT="$3"
PDF_FILE=$OUT/`basename ${FILE%.tex}.pdf`


if ! test_xelatex "$TEXMF" "$FILE" "$OUT" ; then
	err "Can't compile $FILE"
	exit 1
fi

if ! [ -f $PDF_FILE ] ; then
	info "No PDF file created, doesn't create PNG"
	exit 0
fi

if ! pdf_to_png $PDF_FILE $OUT ; then
	err "Can't convert PDF ($FILE) to PNG"
	exit 1
fi

green "Test results for $FILE created."

