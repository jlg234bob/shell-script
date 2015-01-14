#!/usr/bin/env bash
# author: liguo
# sumary: ex02.sh

while read line;do
echo $line | tr [:lower:] [:upper:] | sed -r 's/([0-9]{3})([A-Z]{3})([0-9]{3})/\3\2\1/' 
done << EOF
123abc456
456def123
567abc789
789def567
EOF
