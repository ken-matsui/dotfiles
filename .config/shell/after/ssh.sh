#!/usr/bin/env sh

if ! command_exists pass-cli; then
  return
fi

export SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-agent.sock"
