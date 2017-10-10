#!/bin/bash

ROOTDIR=`dirname ${BASH_SOURCE[0]}`/..

echo "This may take a bit..." 1>&2

grep -hE "(RequireP|usep)ackage{" -r $ROOTDIR | \
	sed "s/^.*{\([^}]*\)}.*\$/\1/" | \
	sed "s/,/\\n/g" | sort | uniq | \
while read pkgname ; do
	dpkg-query -S "*/$pkgname.sty"
done | sed "s/^\([^:]*\):.*\$/\1/" | sort | uniq

echo "Done." 1>&2
