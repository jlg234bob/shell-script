#!/usr/bin/env bash
# author: liguo
# sumary: ex03b.sh

# use variables to generate long regex for sed, let code more readable
key="([0-9\.]{7})"
sps="[[:space:]]+"
val="([0-9]{2})"
lne="$key$sps$val"
re="$lne$sps$lne$sps$lne$sps$lne"
sed -r "N;N;N;s/\n/ /g;s/$re/\1 \2 \4 \6 \8/g" << EOF
1.1.1.1 11 
1.1.1.1 22
1.1.1.1 33
1.1.1.1 44
2.2.2.2 11 
2.2.2.2 22
2.2.2.2 33
2.2.2.2 44
EOF
