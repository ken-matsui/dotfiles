#!/bin/bash

cd $(dirname $0)

git pull origin master
DIFF=$(git status)
if [[ $DIFF -ne *"files"* ]]; then
    :
else
    git add -A .
    git commit -m ":sparkles: Auto update by launchd"
    git push origin master
fi

brew update
brew upgrade
brew cask upgrade
brew cleanup -s

