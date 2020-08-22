#!/bin/bash
DATE=`date '+%Y/%m/%d/%H:%S'`
git add .
git commit -m "$DATE"
git push
