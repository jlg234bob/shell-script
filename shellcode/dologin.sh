#/usr/bin/env bash
# simulate login
echo -n 'user name: '
read n
echo -n 'password: '
read p

echo $n, $p
if [ "$n" = "zkl" ] && [ $p = "234" ];then
	echo 'login success!'
else
	echo 'login fail.'
fi
