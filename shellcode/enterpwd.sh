#!/usr/bin/env bash
function enterpwd(){
	echo -e 'Enter password: '
	stty -echo
	read passwd
	stty echo
	echo passwd read
	echo $passwd
}
enterpwd
