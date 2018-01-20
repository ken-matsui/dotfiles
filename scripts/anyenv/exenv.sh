#!/bin/bash

brew install erlang 1>/dev/null
brew install elixir-build 1>/dev/null
export PATH="$HOME/.anyenv/bin:$PATH"
anyenv install exenv 1>/dev/null
eval "$(anyenv init - --no-rehash)"
newest=$(exenv install -l | grep -v : | grep -v - | grep -v / | head -1)
exenv install $newest 1>/dev/null
exenv global $newest
