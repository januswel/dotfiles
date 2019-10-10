#!/bin/sh

#
# refer: https://qiita.com/kkdd/items/88581a2d04843c3c7ce7
#
# Usage
#   history -E 1 | history-histogram.sh
#

cat ~/.zsh_history | tr ';' ' ' | awk '{print $3}' | sort | uniq -c | sort -k1nr | awk '{printf "%32s %4d\n",$2,$1;}'| awk '!max{max=$2;}{f=50/max;if(f>1)f=1;i=$2*f;r="";while(i-->0)r=r"#";printf "%s %s\n",$0,r;}'
