#!/bin/bash

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
  echo 'Installing Xcode command line tools ...'
  check="$(xcode-select --install 2>&1)"
  str='xcode-select: note: install requested for command line developer tools'
  while [[ $check == $str ]]; do
    check="$(xcode-select --install 2>&1)"
    sleep 1
  done
elif [ "$_ostype" = Linux ]; then
  # https://askubuntu.com/a/459425
  local _distrotype="$(awk -F= '/^NAME/{print $2}' /etc/os-release)"
  if [ "$_distrotype" = '"Ubuntu"' ]; then
    echo 'Installing git & zsh ...'
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y git zsh
    chsh -s $(which zsh)
  else
    echo "$_distrotype is not supported."
    exit 1
  fi
else
  echo "'$_ostype' is not supported."
  exit 1
fi

echo 'Installing Homebrew ...'
yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
  echo 'Homebrew installation seems broken.'
  exit 1
fi

echo 'Installing ken-matsui/dotfiles ...'
git clone https://github.com/ken-matsui/dotfiles.git
export DOTSPATH="$(cd $(dirname $0); pwd)/dotfiles"

# Additional installation for macOS
if [ "$_ostype" = Darwin ]; then
  echo 'Installing ansible & mas ...'
  brew install ansible mas

  # Install software that I need
  echo 'Running ansible ...'
  ansible-playbook ${DOTSPATH}/playbook/main.yml -i ${DOTSPATH}/playbook/hosts

  # Accept license
  sudo xcodebuild -license accept
fi

echo 'Installing Rust ...'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

gh auth login
gh ext install seachicken/gh-poi

echo 'Linking config files ...'
ln -s ${DOTSPATH}/.config/ ~/.config
ln -s ${DOTSPATH}/.gnupg/ ~/.gnupg
ln -sf ${DOTSPATH}/.z* ~/

# https://stackoverflow.com/a/13785716
sudo chmod -R 755 /usr/local/share/zsh

printf '\u2728\e[1;33m Dotfiles Installation Done \u2728 \e[m\n'
read '?Press any key to reboot your computer...: '

# Restart to make the setting effective
sudo reboot
