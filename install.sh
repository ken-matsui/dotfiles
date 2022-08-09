#!/bin/zsh

cd ~/

# Created by figlet command
echo '
     _       _    __ _ _
  __| | ___ | |_ / _(_) | ___  ___
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/
'

# Ask for the administrator password upfront
printf 'Password for your PC [\e[32m?\e[m] ' && sudo -v
# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
echo ''

local _ostype="$(uname -s)"
if [ "$_ostype" = Darwin ]; then
  zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ken-matsui/dotfiles/main/install-macos.sh)"
else
  echo "'$_ostype' is not supported."
  exit 1
fi

# Install Rust
echo 'Installing Rust ...'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

# Install gh extensions
gh extension install seachicken/gh-poi

# Link config files
echo 'Linking config files ...'
ln -s ${DOTSPATH}/.config/ ~/.config
ln -s ${DOTSPATH}/.gnupg/ ~/.gnupg
ln -sf ${DOTSPATH}/.z* ~/

# https://stackoverflow.com/a/13785716
sudo chmod -R 755 /usr/local/share/zsh

# Print logs
printf '\u2728\e[1;33m Dotfiles Installation Done \u2728 \e[m\n'
read '?Press any key to reboot your computer...: '

# Restart to make the setting effective
sudo reboot
