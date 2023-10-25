#!/bin/bash
set -eu

sudo apt purge thunderbird
sudo apt purge aisleriot gnome-mahjongg gnome-mines gnome-sudoku
sudo apt install -y gnome-tweaks
sudo apt install -y gnome-shell-extensions
sudo apt install -y gnome-shell-extension-manager
sudo apt install -y universal-ctags
sudo apt install -y ubuntu-restricted-extras  # to play .mov files
sudo apt install -y zsh
chsh -s $(which zsh)
