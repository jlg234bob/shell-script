#!/usr/bin/env bash
path=${1:-'/home/liguo/shellcode/test'}
if [ ! -e $path ];then
	echo "Error: directory is invalid: $path"
	exit -1
fi

if [ ! -z ${path##*/} ];then
	path=$path"/"
fi

ls $path -l | awk -vnpath="$path" ' # pass $path into awk by option -v, npath is new variable name in awk.
BEGIN {getline;} 
{
	cmd="ls "npath" -lS | md5sum "npath$9" | cut -d'\'' '\'' -f1";
	printf $9" ";
	system(cmd);
}' | sort -k 2,2 | awk -vnpath="$path" '
GEGIN{
	getline;
	name1=$1;
	sum1=$2;
}
{
	name2=$1
	sum2=$2;
	if(sum1==sum2){
		delcmd="rm "npath""name1;
		print "Remove duplicated file: " name1;
		system(delcmd);
	}
	name1=name2;
	sum1=sum2;
}'
