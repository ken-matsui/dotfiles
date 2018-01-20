#!/bin/bash

set -e

cd ~/
ARCHIVE="https://github.com/matken11235/dotfiles/archive/master.zip"
curl -fsSLO $ARCHIVE
unzip -q ${ARCHIVE##*/}
mv $(echo ${ARCHIVE%.*} | awk -F '/' '{printf $5"-"$7}') dotfiles
chmod +x ./dotfiles/scripts/init.sh
exec $_
