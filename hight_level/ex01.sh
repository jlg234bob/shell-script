#!/usr/bin/env bash
# author: liguo
# sumary: ex01.sh
  
awk -F$'\t' '{
if(NR==1){
	sum=$1;
	next; 
}

print sum;
print $0;
sum+=$2;
}' << EOF
100
a	100
b	-50
c	-20
d	-30
EOF
