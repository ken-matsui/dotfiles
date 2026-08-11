#!/usr/bin/env sh

if [ -S "$HOME/.1password/agent.sock" ]; then
  export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
fi
