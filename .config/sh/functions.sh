#!/usr/bin/env sh

alias sizeof='du -sh'

info() {
  printf '\033[0;1;34minfo\033[0m: %s\n' "$*" >&2
}
warn() {
  printf '\033[0;1;33mwarning\033[0m: %s\n' "$*" >&2
}
err() {
  printf '\033[0;1;31merror\033[0m: %s\n' "$*" >&2
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

is_bash() {
  [ "$SHELL_NAME" = 'bash' ]
}
is_zsh() {
  [ "$SHELL_NAME" = 'zsh' ]
}

require_bash_or_zsh() {
  FILE="$1"

  if is_bash || is_zsh; then
    return 0
  else
    err "$FILE: Unsupported shell '$SHELL_NAME'. Please use bash or zsh."
    return 1
  fi
}

calc() {
  echo "$*" | bc
}
