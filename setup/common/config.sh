#!/bin/bash
set -eu

# TODO: On Ubuntu, there should already be the ~/.config directory. Needs some tweaks here.
ln -s ${DOTSPATH}/.config/ ~/.config
# TODO: On Ubuntu, .z* file was already created. Needs investigation.
ln -sf ${DOTSPATH}/.z* ~/
ln -s ${DOTSPATH}/.vim ~/.vim
