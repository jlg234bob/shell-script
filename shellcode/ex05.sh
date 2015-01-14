#!/usr/bin/env bash
# author: liguo
# summary: ex05.sh

# usage: 0x05.sh [number]
# example: 
#	bash ex05.sh 10000
#	The final left number is: 6746


# open debug options 
#set -x
#export PS4="+[$LINENO:${FUNCNAME[0]}]"
#trap 'echo "n1=$n1, n2=$n2, n3=$n3, ni=$ni, aa[y-n3]=${aa[$[y-n3]]}, aa[y]=${aa[$y]}, y=$y"' DEBUG

# validate number count of the last outter loop
if [[ $1 =~ ^[0-9]+$ ]];then # test if $1 is a valid number.
	n0=$1
else
	n1=100
fi

let n1=n0 # the outter loop index uplimit of the outter loop
let n2=n1 # real time valid number count
let ni=0 # the counter, we need it to increases without restore to 1. But variable i will do.

for ((i=1;n1>1;i=i%n1+1));do
	let ni++
	if [ $[ni%12] -eq 0 ];then
		let aa[i]=0
		let n2--
		let n3=n1-n2
		# when n0 is large value, ni will be very large,
		# it's very possible to overflow. So reset it to 0, it will more easy to calculate ni%12 too. 
		let ni=0 
	elif ((n1==n0));then # if it is the firt time of the  out loop, fill array aa with value i.
		let aa[i]=i
	fi

	if ((n2<n1 && aa[i]!=0));then
		# remove some number that at the position of 12*n, now move later array elements left 
		# to fill these empty positons. Then it will loop fewer positions after loop index i restore to 1. 
		# This is important when variable n0 is a large number, such as 1000,000
			if ((n3>0));then
				let aa[i-n3]=aa[i]
			fi
	fi

	# make i==n1, ensure outter loop index 'i' restart from 1 after operation 'i=i%n1+1'	
	if ((i==n1 && n2<n1));then
		let n1=n2
		let i=n1 
		let n3=0
	fi
done

echo "The final left number is: ${aa[$n1]}"

# close debug options
#set +x
#export PS4="+"
