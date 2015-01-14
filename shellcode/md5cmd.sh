#!/usr/bin/env bash
# author: liguo
# sumary:genenrate md5sum for common cmd files

# generate cmd list
cat >list <<EOF
/bin/ping
/usr/bin/finger
/usr/bin/who
/usr/bin/w
/usr/bin/locate
/usr/bin/whereis
/usr/bin/ifconfig
/usr/bin/vi
/usr/bin/vim
/usr/bin/which
/usr/bin/gcc
/usr/bin/make
/usr/bin/rpm
EOF

rm -f /var/log/cmdsum.log
for f in `cat list`;do
	if [ ! -x $f ];then
		echo "$f doesn't exists."
	else
		md5sum $f >>/var/log/cmdsum.log
	fi
done	
rm -f list
echo
echo Created md5sum for below files:
echo "--------------------------------"
cat /var/log/cmdsum.log

echo
echo "check md5sum with generated sums:"
echo "---------------------------------------------"
md5sum -c /var/log/cmdsum.log
