#!/usr/bin/env sh

if command_exists starship; then
  if require_bash_or_zsh "$0"; then
    eval "$(starship init "$SHELL_NAME")"
  fi
fi
