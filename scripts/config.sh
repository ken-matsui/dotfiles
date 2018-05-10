# /bin/bash


# Change shell as default for USER(not root).
sudo chsh -s /bin/zsh "${USER}" 1>/dev/null
# Install zsh-prezto.
git clone -q --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Install tpm
git clone -q https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install fonts.
brew tap sanemat/font 1>/dev/null
brew reinstall --with-powerline ricty 1>/dev/null
font_ver=`ls /usr/local/Cellar/ricty`
cp -f /usr/local/Cellar/ricty/${font_ver}/share/fonts/Ricty*.ttf ${HOME}/Library/Fonts/

# Link setting files.
for conf in `find ${DOTSPATH}/config -type f`; do
	ln -sf "${DOTSPATH}/config/${conf##*/}" "${HOME}/${conf##*/}"
done

