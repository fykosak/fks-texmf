#!/bin/bash

#
# Logging functions
# 

_GREEN='\E[32;40m'
_YELLOW='\E[33;40m'
_RED='\E[31;40m'
_BLUE='\E[34;40m'
_NOCOLOR=''

LOG_ERROR=1
LOG_WARN=2
LOG_INFO=3
LOG_VERBOSE=$LOG_INFO

_log_level=$LOG_ERROR


function _log {
	local level=$1
	local color=$2
	local msg=$3

	if [ $level -le $_log_level ] ; then
		echo -e "$color$msg" >&2 ; tput sgr0
	fi
}

function log_init {
	_log_level=$1
}

function err {
	_log $LOG_ERROR $_RED "$1"
}

function warn {
	_log $LOG_WARN $_YELLOW "$1"
}

function info {
	_log $LOG_INFO $_NOCOLOR "$1"
}

function green {
	_log $LOG_INFO $_GREEN "$1"
}

#
# Compiling functions
#

# Call xelatex in TEST environment
function test_xelatex {
	local texmf=$1
	local file=$2
	local out=$3

	local dir=`dirname $file`

	TEXMFHOME="$texmf" TEXINPUTS="$dir:" \
	  xelatex -interaction nonstopmode -output-directory "$out" \
	  -halt-on-error "$file" &>/dev/null
}

function pdf_to_png {
	local file=$1
	local out=$2

	local png_stem=`basename ${file%.pdf}`
	local log_file=$out/${png_stem}-render.log

	cmd="pdftoppm \
		-r 500 -png -freetype yes -thinlinemode none -aa yes -aaVector yes \
		$file $out/$png_stem"
	$cmd &>$log_file
}

#
# Input: TeX filename
# Output: test_args (variable)
function parse_test_args {
	local file=$1
	local key value
	unset test_args
	declare -gA test_args

	while IFS="=" read key value ; do
		test_args["$key"]="$value"
	done < <(
		grep "^%META_TEST" $file | sed 's/^%META_TEST *//'
	)
}
