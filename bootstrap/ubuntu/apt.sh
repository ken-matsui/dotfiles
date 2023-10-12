#!/bin/bash
set -eu

sudo apt purge thunderbird
sudo apt purge aisleriot gnome-mahjongg gnome-mines gnome-sudoku
sudo apt install gnome-tweaks
sudo apt install gnome-shell-extensions
sudo apt install gnome-shell-extension-manager
sudo apt install universal-ctags
sudo apt install ubuntu-restricted-extras  # to play .mov files
