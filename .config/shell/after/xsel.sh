#!/usr/bin/env sh

if command_exists xsel; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'

  if command_exists tmux; then
    tmux set -s copy-command 'xsel --clipboard --input'
  fi
fi
