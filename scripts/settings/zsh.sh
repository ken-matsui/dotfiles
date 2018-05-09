#!/bin/bash

# Change shell as default for USER(not root).
sudo chsh -s /bin/zsh "${USER}" 1>/dev/null
# Install zsh-prezto.
git clone -q --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# Link setting files.
for setting in `find ${DOTSPATH}/settings/zsh -maxdepth 1 -type f`; do
	ln -sf "${DOTSPATH}/settings/zsh/${setting##*/}" "${HOME}/${setting##*/}"
done
