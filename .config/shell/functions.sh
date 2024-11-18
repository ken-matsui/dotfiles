#!/usr/bin/env sh

##################################
# Functions
##################################

alias sizeof='du -sh'

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

info() {
  printf '\033[0;34m[INFO]: %s\033[0m\n' "$*"
}
warn() {
  printf '\033[0;33m[WARNING]: %s\033[0m\n' "$*"
}
err() {
  printf '\033[0;31m[ERROR]: %s\033[0m\n' "$*"
}

calc() {
  echo "$*" | bc
}
