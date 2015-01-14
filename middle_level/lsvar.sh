#!/bin/bash
#: Title:lsvar
#: Synopsis:

for file in `ls /var`; do
	bchar=`echo "$file" | sed 's/\([a-zA-Z]\).*/\1/g' | tr 'a-z' 'A-Z'`
	echar=`echo "$file" | sed 's/.*\([a-zA-Z]\)/\1/g' | tr 'a-z' 'A-Z'`
	echo "$file" | sed "s/[a-zA-Z]\(.*\)[a-zA-Z]/$bchar\1$echar/g"
done
