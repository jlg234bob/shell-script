#!/usr/bin/env bash
# check the status of IP from 192.168. 1,100, 124, 130
iph='192.168.1.'
ipts=(1 100 124 130)
for ipt in ${ipts[*]};do
	ip=$iph$ipt
	ping -c 3 -i 0.3 -w 1.5 $ip>/dev/null
	
	if [ $? -eq 0 ];then
		echo "$ip is online."
	else
		echo "$ip is not online."
	fi
done

