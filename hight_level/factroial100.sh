#!/usr/bin/env bash
# calculate 10's factorial
f=1
for n in `seq 1 10`;do
	f=$[f*n]
done
echo "factorial of 10 is '$f'"
