# /bin/bash


# Change shell as default for USER(not root).
sudo chsh -s /bin/zsh "${USER}" 1>/dev/null
# Install zsh-prezto.
git clone -q --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# Install fonts.
brew tap sanemat/font 1>/dev/null
brew reinstall --with-powerline ricty 1>/dev/null
font_ver=`ls /usr/local/Cellar/ricty`
cp -f /usr/local/Cellar/ricty/${font_ver}/share/fonts/Ricty*.ttf ${HOME}/Library/Fonts/

# Link setting files.
for setting in `find ${DOTSPATH}/settings -type f`; do
	ln -sf "${DOTSPATH}/settings/${setting##*/}" "${HOME}/${setting##*/}"
done

