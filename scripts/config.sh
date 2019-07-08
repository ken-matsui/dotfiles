#!/bin/bash

# Change shell as default for USER(not root).
sudo chsh -s /bin/zsh "${USER}" 1>/dev/null
# Install zsh-prezto.
git clone -q --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Install tpm
git clone -q https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# accept
sudo xcodebuild -license accept

# Install Ricty with Powerline
brew install sanemat/font/ricty --with-powerline 1>/dev/null
cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -f 1>/dev/null

# Link setting files.
for conf in $(find config -type f | grep -e 'zsh' -e 'zprezto' -e 'hyper'); do
	ln -sf $conf ~/${conf##*/}
done

# Create directory
mkdir ~/.config
# link
ln -sf ${DOTSPATH}/config/nvim/ ~/.config/nvim
