#!/usr/bin/env bash
# convert decimal value to binary value

if [[ ! $1 =~ ^[1-9][0-9]*$ ]];then
	echo "error: $1 is not a valid decimal value."
	exit -1
fi

d=$1 # decimal value
r='' # result, a binary value
while [ $d -gt 0 ];do
	r=$[d%2]$r
	d=$[d/2]
done
echo $r
