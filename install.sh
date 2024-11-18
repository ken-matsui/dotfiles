#!/bin/bash
set -eu

cd $HOME
echo 'Installing dotfiles ...'

case "$(uname)" in
  Darwin)
    # Ask for the administrator password upfront
    printf 'Password for your PC [\e[32m?\e[m] ' && sudo -v
    # Keep-alive: update existing `sudo` time stamp until this script has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    echo ''

    echo 'Installing Xcode command line tools ...'
    check="$(xcode-select --install 2>&1)"
    str='xcode-select: note: install requested for command line developer tools'
    while [ "$check" == "$str" ]; do
      check="$(xcode-select --install 2>&1)"
      sleep 1
    done
    ;;

  Linux)
    # https://askubuntu.com/a/459425
    local _distrotype="$(awk -F= '/^NAME/{print $2}' /etc/os-release)"
    if [ "$_distrotype" != '"Manjaro Linux"' ]; then
      echo "$_distrotype is not supported."
      exit 1
    fi
    ;;

  *)
    echo "'$(uname)' is not supported."
    exit 1
    ;;
esac

echo 'Downloading ken-matsui/dotfiles ...'
git clone https://github.com/ken-matsui/dotfiles.git
export DOTSPATH="$(cd $(dirname $0); pwd)/dotfiles"
bash ${DOTSPATH}/setup/main.sh

printf '\u2728\e[1;33m Dotfiles Installation Done \u2728 \e[m\n'
read '?Press any key to reboot your computer...: '

# Restart to make the setting effective
sudo reboot
