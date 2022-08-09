#!/bin/zsh

sudo apt update
sudo apt -y upgrade
sudo apt install -y \
  git \
  neovim \
  zsh

# Install dotfiles
echo 'Installing ken-matsui/dotfiles ...'
git clone https://github.com/ken-matsui/dotfiles.git
export DOTSPATH="$(cd $(dirname $0); pwd)/dotfiles"
