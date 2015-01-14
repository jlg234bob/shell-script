#!/usr/bin/env bash
# count failed login by SSH


userip_logins="/tmp/userip_logins$$.log"
fail_logins="/tmp/fail_logins$$.log"
cat /var/log/secure | grep -E "authentication failure(s)?;" > $fail_logins

users=$(cut -d '=' -f8 $fail_logins | uniq)
ip_list=$(cut -d '=' -f7 $fail_logins | uniq | cut -d ' ' -f1)

echo -e "user\thost IP\t\tfail login\tperiod(seconds)"
for user in $users;do
for ip in $ip_list;do
	grep "rhost=$ip.*user=$user" $fail_logins > $userip_logins
	login_count=$(wc -l $userip_logins | cut -d' ' -f1)
	tstart=$(head -1 $userip_logins | cut -c -16)
	start=$(date -d "$tstart" "+%s")
	tend=$(tail -1 $userip_logins | cut -c -16)
	end=$(date -d "$tend" "+%s")
	period=$[$end-$start]
	echo -e "$user\t$ip\t$login_count\t\t$period"
done
done
