#!/usr/bin/env sh

if command_exists lsd; then
  alias ls='lsd'
  alias tree='lsd --tree'
fi
