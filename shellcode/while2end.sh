#!/usr/bin/env bash
read -p "input something to print: " instr
while [ "$instr" != "end" ];do
	echo $instr
	read -p "input something to print: " instr
done
