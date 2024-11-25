#!/bin/sh
set -eu

DOTSPATH="${DOTSPATH:-$HOME/dotfiles}"

# If the file/directory already exists, rename it to .bak
backup_and_link() {
  TARGET="${2:+$2/$(basename "$1")}"
  TARGET="${TARGET:-$HOME/$1}"

  if [ -e "$TARGET" ]; then
    echo "Backing up $TARGET to $TARGET.bak ..."
    mv "$TARGET" "$TARGET.bak"
  fi
  echo "Linking $DOTSPATH/$1 to $TARGET ..."
  ln -s "$DOTSPATH/$1" "$TARGET"
}

if [ "$(uname)" = Darwin ]; then
  # TARGET=$HOME/Library/Application Support/Code
  backup_and_link .config/Code "$HOME/Library/Application Support"
elif [ "$(uname)" = Linux ]; then
  # TARGET=$HOME/.config/Code
  backup_and_link .config/Code
fi

backup_and_link .config/1Password
backup_and_link .config/alacritty
backup_and_link .config/atuin
backup_and_link .config/git
backup_and_link .config/helix
backup_and_link .config/neomutt
backup_and_link .config/nvim
backup_and_link .config/psync
backup_and_link .config/shell
backup_and_link .config/sway
backup_and_link .config/tmux
backup_and_link .config/topgrade
backup_and_link .config/vim
backup_and_link .config/w3m
backup_and_link .config/waybar
backup_and_link .config/starship.toml
backup_and_link .ssh
backup_and_link .Brewfile
backup_and_link .bash_profile
backup_and_link .bashrc
backup_and_link .zshenv
backup_and_link .zshrc
