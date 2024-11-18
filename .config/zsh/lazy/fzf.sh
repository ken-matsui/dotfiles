#!/usr/bin/env sh

[ -f "$HOME"/.fzf.zsh ] && . "$HOME"/.fzf.zsh
[ -f "$HOME"/.fzf.bash ] && . "$HOME"/.fzf.bash

if command_exists fzf; then
  export FZF_DEFAULT_OPTS="--height 12"
fi
