#!/bin/bash

# Install fonts.
brew tap sanemat/font 1>/dev/null
brew reinstall --with-powerline ricty 1>/dev/null
font_ver=`ls /usr/local/Cellar/ricty`
cp -f /usr/local/Cellar/ricty/${font_ver}/share/fonts/Ricty*.ttf ${HOME}/Library/Fonts/
# Link setting files.
for setting in `find ${DOTSPATH}/settings/iTerm2 -maxdepth 1 -type f`; do
	ln -sf "${DOTSPATH}/settings/iTerm2/${setting##*/}" "${HOME}/Library/Preferences/${setting##*/}"
done
