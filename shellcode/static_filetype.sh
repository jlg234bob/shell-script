#!/usr/bin/env bash
# list file types and file count under a path
p=$1
if [ ! -d $p ];then
	echo "Error: invalid directory: "$p
	exit -1
elif [ ! $p ];then # if not dir input, use current directory
	p="./"
fi

if [[ ! $p =~ /$ ]];then # if dir string doesn't end with '/', add '/' to its end. e.g. /dev => /edv/
	p="$p/"
fi

echo "path: $p"
echo -e "count\ttype"
ls $p | awk -vnp="$p" '{print np""$0;}' | xargs file -b 2>/dev/null | sort | awk '
BEGIN {
	getline;
	if($0""==""){
		fn=0; /* record total file count */
		ln=0; /* record the file count in current file type */
		exit;
	}
	l1=$0;ln=1; /* l1 is the first file type name */
} 
{
	l2=$0; /* l2 is the later file type name */
	if(l1==l2){
		ln=ln+1;l1=l2;next;
	}else{
		fn=fn+ln;
		print ln"\t"l1;l1=l2;ln=1;
	}
} 
END {
	fn+=ln; /* add the last file type''s file count to total file count */
	if(ln!=0){
		print ln"\t"l1;
	}
	print "total files: "fn;
}'
