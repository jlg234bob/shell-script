#!/usr/bin/env bash
# author: liguo
# sumary: static file types and file count under each type. 
# 	Upgrade code from static_filetype.sh according to great code from network.

if [ $# -eq 0 ];then
	p="./"
elif [ -d $1 ];then
	p=$1
else
	echo "Error - invalid directory: " $1
	exit -1
fi

declare -A ary
tf=0 # total file count
while read -r file;do
	let tf++
	filetype=`file -b "$file"`
	let ary["$filetype"]++
done < <(find $p -type f -print)

echo "path: $p"
echo -e "file count\tfile type"
for filetype in "${!ary[@]}";do
	echo -e ${ary["$filetype"]}"\t${filetype}"
done
echo "Total file count: " $tf
