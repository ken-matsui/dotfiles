#!/bin/bash

cd $(dirname $0)

DIFF=$(git status)
echo $DIFF
if [[ $DIFF -ne *"files"* ]]; then
    :
    echo $(pwd)
else
    git add -A .
    git commit -m ":sparkles: Auto update by cron"
    git push origin master
fi

