#!/usr/bin/env bash
fns=$(ls /var)
for fn in $fns;do
	bchar=`echo $fn | sed 's/\([a-zA-Z]\).*/\1/' | tr [:lower:] [:upper:]`
	echar=`echo $fn | sed 's/.*\([a-zA-Z]\)/\1/' | tr [:lower:] [:upper:]`
	mstr=`echo $fn | sed 's/[a-zA-Z]\(.*\)[a-zA-Z]/\1/'`
	echo $bchar$mstr$echar
done
