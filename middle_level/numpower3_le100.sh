#!/usr/bin/env bash
c=0
for n in `seq 1 100`;do
	if [ $[n%3] -eq 0 ];then
		echo -en "$n\t"
		let c++
		if [ $[c%10] -eq 0 ];then
			echo
		fi
	fi
done
echo
