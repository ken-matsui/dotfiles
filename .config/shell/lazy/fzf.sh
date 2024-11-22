#!/usr/bin/env sh

is_zsh && [ -f "$HOME"/.fzf.zsh ] && . "$HOME"/.fzf.zsh
is_bash && [ -f "$HOME"/.fzf.bash ] && . "$HOME"/.fzf.bash

if command_exists fzf; then
  export FZF_DEFAULT_OPTS="--height 12"
fi
