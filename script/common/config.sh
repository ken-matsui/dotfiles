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

ALL='
.config/alacritty
.config/atuin
.config/git
.config/nvim
.config/shell
.config/sway
.config/tmux
.config/topgrade
.config/vim
.config/waybar
.config/starship.toml
.ssh
.Brewfile
.zshenv
.zshrc
'

MINIMAL='
.config/git
.config/nvim
.config/shell
.config/tmux
.config/vim
.config/starship.toml
.zshenv
.zshrc
'

if [ "$#" -eq 0 ]; then
  ITEMS="$ALL"
elif [ "$1" = 'minimal' ]; then
  ITEMS="$MINIMAL"
else
  ITEMS="$1"
fi

mkdir -p "$HOME/.config"

for item in $ITEMS; do
  backup_and_link "$item"
done
