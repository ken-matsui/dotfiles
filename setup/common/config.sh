#!/bin/bash
set -eu

# If the file/directory already exists, rename it to .bak
backup_and_link() {
  if [ -d ~/$1 ]; then
    mv ~/$1 ~/$1.bak
  fi
  ln -s ${DOTSPATH}/$1 ~/$1
}

backup_and_link .config
backup_and_link .local/share/alacritty/config.toml
backup_and_link .ssh
backup_and_link .vim
backup_and_link .w3m
backup_and_link .bashrc
backup_and_link .zshenv
backup_and_link .zshrc
