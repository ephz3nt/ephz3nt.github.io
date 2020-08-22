#!/bin/bash
YEAR=`date '+%Y'`
if [ -z $1 ];then
	echo "no categories"
	echo "usage: "
	echo "hugo new [categories] [postname]"
else
hugo new posts/$1/$YEAR/$2.md
fi
