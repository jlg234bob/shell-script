#!/usr/bin/env bash
for f in `find $HOME -name '*.sh'`;do
	echo `basename $f`
done
