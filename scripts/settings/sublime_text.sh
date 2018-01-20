#!/bin/bash

# Link setting files.
setting() {
	for setting in `find $1 -maxdepth 1 -type f`; do
		ln -sf "${1}/${setting##*/}" "${2}/${setting##*/}"
	done
}
mkdir -p "${HOME}/Library/Application\ Support/Sublime\ Text\ 3/Packages/Packages/User"
mkdir -p "${HOME}/Library/Application\ Support/Sublime\ Text\ 3/Packages/Local"
setting "${DOTSPATH}/settings/SublimeText/User" "${HOME}/Library/Application\ Support/Sublime\ Text\ 3/Packages/Packages/User"
setting "${DOTSPATH}/settings/SublimeText/Local" "${HOME}/Library/Application\ Support/Sublime\ Text\ 3/Packages/Local"
