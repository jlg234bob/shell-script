#!/usr/bin/env bash
# test case statement
read -p 'Please press any key: ' key
case $key in
	[a-zA-Z])
		echo "alpha"
		;;
	[0-9])
		echo "number"
		;;
	*)
		echo "other char"
esac
