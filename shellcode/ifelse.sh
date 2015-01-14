#!/usr/bin/env bash
# test if else statement
read -p 'Input your score: ' g
if [ $g -ge 90 ]; then
	echo 'greate!'
elif [ $g -ge 80 ] ; then
	echo 'good.'
elif [ $g -ge 60 ]; then
	echo 'ok'
else
	echo 'bad'
fi
