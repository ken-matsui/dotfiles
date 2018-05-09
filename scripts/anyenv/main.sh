#!/bin/bash

# Install anyenv and *env
git clone -q https://github.com/riywo/anyenv ~/.anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init - --no-rehash)"
git clone -q https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
ENVDIR="${DOTSPATH}/scripts/anyenv"
for file in $( ls $ENVDIR ); do
	bash ${ENVDIR}/${file}
done

