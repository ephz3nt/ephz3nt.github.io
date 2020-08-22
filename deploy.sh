#!/bin/bash
DATE=`date '+%Y-%m-%d-%S'`
git add .
git commit -m "$DATE"
git push
