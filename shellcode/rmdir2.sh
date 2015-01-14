#!/usr/bin/env bash
# remove dir if it exits
if [ -d $1 ];then
	rmdir $1
	echo "$1 removed."
else
	echo "$1 doesn't exits, remove dir fail."
fi
