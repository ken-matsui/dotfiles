#!/usr/bin/env sh

if ! command_exists pass-cli; then
  return
fi

_pp_sock="$HOME/.ssh/proton-pass-agent.sock"
export SSH_AUTH_SOCK="$_pp_sock"
# if [ -S "$_pp_sock" ]; then
#     export SSH_AUTH_SOCK="$_pp_sock"
# fi
