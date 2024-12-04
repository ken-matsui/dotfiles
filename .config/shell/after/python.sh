#!/usr/bin/env sh

if command_exists brew; then
  export PATH="$HOMEBREW_PREFIX/bin:$PATH"
  export PATH="$(brew --prefix python@3)/libexec/bin:$PATH"
fi
