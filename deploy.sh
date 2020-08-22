#!/bin/bash
DATE=`date '+%Y-%m-%D'`
git add .
git commit -m "$DATE"
git push
