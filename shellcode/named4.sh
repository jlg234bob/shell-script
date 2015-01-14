#!/usr/bin/env bash
# author: liguo
# sumary:install DNS service, then add domain names to test DNS service

## block for debug
#set -x # open shell option -x
#export PS4='+[$LINENO:${FUNCNAME[0]}]'
#trap 'echo "($DOMAIN_N_ALL)"' DEBUG

PKG="bind bind-chroot"
M_CONF="/etc/named.conf"
R_CONF="/etc/named.rc1912.zones"
MYIP=$(ifconfig eth0 | grep 'inet addr:' | awk -F[:' ']+ '{print $4}')

HELP()
{
cat << EOF
usage: $0 [option]
option: -d dn1 dn2 ... // example: -d baidu.com sina.com
EOF
exit 1
}

# test domai name, check if it is invalid.
TEST_D() 
{
	echo "domain name=$1"
	echo $1 | grep '.*\..*\|.*\..*\..*' &>/dev/null
	[ $? -ne 0 ] && HELP ## if domain name is invalid, show help
}

# install bind and bind-chroot package by yum
INSTALL_PKG()
{

	UNPKG=""
	for p in $PKG;do
		rpm -q $p &> /dev/null
		[ $? -ne 0 ] && UNPKG="$UNPKG $p"
	done

	IS_SUCCESS="True"
	if [ -n "$UNPKG" ];then
		yum install $UNPKG -y 

		UNPKG2=""
		for p in $UNPKG;do
			rpm -q $p &> /dev/null
			[ $? -ne 0 ] && UNPKG2="$UNPKG2 $p"
		done

		# install PKG the second time if failed	
		[ -n "$UNPKG2" ] && yum install $UNPKG2 -y 

		for p in $UNPKG2;do
			rpm -q $p &> /dev/null
			if [ $? -ne 0 ];then
				echo "error: install $p failed, try install it manually."
				IS_SUCCESS="False"
			fi
		done
	fi
	[ "$IS_SUCCESS" = "False" ] &&  exit 1 || echo "info: install $PKG success!"
}

MAIN_CONF()
{
	sed -i -f /root/shell/sed.txt $M_CONF

	cat >> $R_CONF << EOF
	zone "$DOMAIN_N" IN {
		type master;
		file "$DOMAIN_N.zone";
		allow-update { none; };
	};
EOF

cp -p /var/named/named.localhost /var/named/$DOMAIN_N.zone
sed -i '/127.0.0.1\|AAAA/d' /var/named/$DOMAIN_N.zone
cat >> /var/named/$DOMAIN_N.zone << EOF
	A	$MYIP
www	A	$MYIP
EOF
}

MYTEST()
{
	sed -i "1inameserver $MYIP" /etc/resolv.conf
	service named restart
	for i in $DOMAIN_N_ALL;do
		nslookup $i
	done
}

[ -z "$1" ] && HELP

case $1 in
	-d)
		shift
		TEST_D $1
		DOMAIN_N_ALL="$1"
		shift
		while [ $# -gt 0 ];do
			TEST_D $1
			DOMAIN_N_ALL="$DOMAIN_N_ALL $1"
			shift
		done
	;;
	*)
		HELP
	;;
esac

INSTALL_PKG
for DOMAIN_N in $DOMAIN_N_ALL
do
	MAIN_CONF
done
MYTEST

#set +x # close shell option -x
#export PS4="+"

# /root/shell/sed.txt
#s/127\.0\.0\.1/any/
#s/::1/any/
#s/localhost/any/
#s/^\([[:space:]]\+\)\(dnssec.*\)/\1\/\/\2/

