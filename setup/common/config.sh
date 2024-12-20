#!/bin/sh
set -eu

DOTSPATH="${DOTSPATH:-$HOME/dotfiles}"

# If the file/directory already exists, rename it to .bak
backup_and_link() {
  TARGET="${2:+$2/$(basename "$1")}"
  TARGET="${TARGET:-$HOME/$1}"

  if [ -e "$TARGET" ]; then
    TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"
    BACKUP="$TARGET.bak.$TIMESTAMP"
    echo "Backing up $TARGET to $BACKUP ..."
    mv "$TARGET" "$BACKUP"
  fi
  echo "Linking $DOTSPATH/$1 to $TARGET ..."
  ln -s "$DOTSPATH/$1" "$TARGET"
}

mkdir -p "$HOME/.config"

OS_NAME="$(uname -s)"
if [ "$OS_NAME" = Darwin ]; then
  # TARGET=$HOME/Library/Application Support/Code
  backup_and_link .config/Code "$HOME/Library/Application Support"
elif [ "$OS_NAME" = Linux ]; then
  # TARGET=$HOME/.config/Code
  backup_and_link .config/Code
fi

backup_and_link .config/alacritty
backup_and_link .config/atuin
backup_and_link .config/git
backup_and_link .config/neomutt
backup_and_link .config/nvim
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
backup_and_link .zshenv
backup_and_link .zshrc
