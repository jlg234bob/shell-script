#!/usr/bin/env bash
pro=1
while [ $# -gt 0 ];do
	if [[ ! $1 =~ ^[0-9]+$ ]];then
		echo "warning: $1 is not a valid number. Ignore it."
		shift
		continue
	fi
	pro=$[pro*$1]
	shift
done
echo "product=$pro"
