#!/usr/bin/env bash
# if directory doesn't exist, create it
if [ ! -d $1 ]; then
	mkdir $1
else
	echo "$1 exists, create dir fail."
fi
