#!/bin/bash

export PATH="$HOME/.anyenv/bin:$PATH"
anyenv install ndenv 1>/dev/null
eval "$(anyenv init - --no-rehash)"
newest=$(ndenv install -l | grep -v - | tail -1)
ndenv install $newest 1>/dev/null
ndenv global $newest
