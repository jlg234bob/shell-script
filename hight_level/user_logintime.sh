#!/usr/bin/env bash
# author: liguo
# sumary: static login time of all users

dead_records="/tmp/dead.$$"
active_records="/tmp/active.$$"
user_seconds="/tmp/user_seconds.$$"

last -f /var/log/wtmp | sort -k 1 | grep -v 'still logged in' | awk '{print $1"\t"$NF;}' | tr -d ')(' | tr '+' ':' > $dead_records
last -f /var/log/wtmp | sort -k 1 | grep 'still logged in' | tr -s ' ' | awk -F' ' '{print $1";"$4" "$5"  "$6" "$7;}' > $active_records
declare -A user_seconds

# process dead login records
awk '{
	split($2, tstr, ":");
	tseconds=0;
	lstr=length(tstr);
	for(i=lstr;i>0;i--) tseconds+=tstr[i]*60**(lstr-i);
	user_seconds[$1]+=tseconds;
}
END {
for(user in user_seconds) print user"\t"user_seconds[user];
	
}'  <(sed '/^[[:space:]]*$/d' $dead_records) > $user_seconds 

# process active login records        
declare -A user_times

while read line;do 
	user=$(echo $line | cut -d';' -f1);
	strstart=$(echo $line | cut -d';' -f2);
	tstart=$(date -d "$strstart" "+%s");
	tnow=$(date "+%s");
	tseconds=$[$tnow-$tstart]
	let user_times["$user"]+=$tseconds
done < $active_records

for user in ${!user_times[@]}; do
	echo -e $user"\t"${user_times["$user"]}
done  >> $user_seconds 

declare -A user_hours
while read line;do
	user=$(echo $line | cut -d' ' -f1);
	seconds=$(echo $line | cut -d' ' -f2);
	let user_hours["$user"]+=$seconds
done < $user_seconds

printf "%-15s %-6s\n" "User" "Login time"

for user in ${!user_hours[@]};do
	seconds=${user_hours["$user"]}
	hour=$(echo "scale=2;$seconds/3600.0"|bc)
	printf "%-15s %-6.2fHours\n" $user $hour
done

