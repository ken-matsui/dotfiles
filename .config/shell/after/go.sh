#!/usr/bin/env sh

if command_exists go; then
  export GOPATH="$HOME/go"
  export GOBIN="$GOPATH/bin"
  export PATH="$PATH:$GOBIN"
fi
