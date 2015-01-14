#!/usr/bin/env bash
# author: liguo
# sumary: ex03.sh

proc()
{
	awk '{aa[$1]=length(aa[$1])>0 ? aa[$1]" "$2 : $2;}
	END {
		for(i in aa)
		{
			print i"\t"aa[i];
		}
	}'<< EOF
	1.1.1.1 11
	1.1.1.1 22
	1.1.1.1 33
	1.1.1.1 44
	2.2.2.2 11
	2.2.2.2 22
	2.2.2.2 33
	2.2.2.2 44
EOF
}

proc | sort # lines output by descending by default, sort it by asending here.
