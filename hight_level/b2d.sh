#!/usr/bin/env bash
# convert binary number to decimal number

if [[ ! $1 =~ ^1[01]*$ ]];then
	echo "$1 is not a valid binary number."
	exit -1
fi

r=0 # result, save decimal value
p=0 # binary number bit postition, lowerest is 0,then 1,2,3...
l=${#1} # binary number bit length. e.g. 1001 length is 4
pb=0 # extract binary bit value, the begin position
while [ $p -lt $l ];do
	pb=$[l-p-1]
	n=${1:pb:1}
	let r=r+$[2**p*n]
	let p++
done
echo $r
