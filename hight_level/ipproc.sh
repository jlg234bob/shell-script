#!/usr/bin/env bash
# author: liguo
# sumary: process IP address with IFS for practice
ip="192.168.1.1"
ifs=$IFS
IFS="."
tmpip=$(echo $ip)
echo "tmpip=$tmpip"
IFS=$ifs
echo "tmpip=$tmpip"
echo "ip=$ip"

ip2=""
for x in $tmpip;do
	ip2="${ip2}.${x}"
done
len=$[${#ip2}-1]
# ip2=${ip2:1:$len} # remove dot . from head
ip2=${ip2#.} # remove dot . from head
echo "ip2=$ip2"
IFS=$ifs
