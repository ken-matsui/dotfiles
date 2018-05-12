#!/bin/bash

export PATH="$HOME/.anyenv/bin:$PATH"
anyenv install rbenv 1>/dev/null
eval "$(anyenv init - --no-rehash)"
newest=$(rbenv install -l | grep -v - | tail -1)
rbenv install $newest 1>/dev/null
rbenv global $newest
