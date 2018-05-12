#!/bin/bash

export PATH="$HOME/.anyenv/bin:$PATH"
anyenv install goenv 1>/dev/null
eval "$(anyenv init - --no-rehash)"
newest=$(goenv install -l | tail -1)
goenv install $newest 1>/dev/null
goenv global $newest
