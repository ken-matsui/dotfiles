#!/usr/bin/env sh

alias sizeof='du -sh'

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

info() {
  printf '\033[0;1;34minfo\033[0m: %s\n' "$*" >&2
}
warn() {
  printf '\033[0;1;33mwarning\033[0m: %s\n' "$*" >&2
}
err() {
  printf '\033[0;1;31merror\033[0m: %s\n' "$*" >&2
}

calc() {
  echo "$*" | bc
}
