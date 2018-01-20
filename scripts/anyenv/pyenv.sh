#!/bin/bash

export PATH="$HOME/.anyenv/bin:$PATH"
anyenv install pyenv 1>/dev/null
eval "$(anyenv init - --no-rehash)"
newest=$(pyenv install -l | grep -v - | grep -v b | grep 3.6.* | tail -1)
pyenv install $newest 1>/dev/null
pyenv global $newest
