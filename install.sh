#!/bin/zsh

cd ~/

# Created by figlet command
echo '
     _       _    __ _ _
  __| | ___ | |_ / _(_) | ___  ___
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/
'

# Ask for the administrator password upfront
printf 'Password for your PC [\e[32m?\e[m] ' && sudo -v
# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
echo ''

install_macos() {
  # Install Xcode command line tools
  echo 'Installing Xcode command line tools ...'
  check="$(xcode-select --install 2>&1)"
  str='xcode-select: note: install requested for command line developer tools'
  while [[ $check == $str ]]; do
    check="$(xcode-select --install 2>&1)"
    sleep 1
  done

  # Install Homebrew
  echo 'Installing Homebrew ...'
  yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Install git
  echo 'Installing git ...'
  brew install git

  # Install dotfiles
  echo 'Installing ken-matsui/dotfiles ...'
  git clone https://github.com/ken-matsui/dotfiles.git
  export DOTSPATH="$(cd $(dirname $0); pwd)/dotfiles"

  # Install ansible (and accompany some of it)
  echo 'Installing ansible ...'
  brew install ansible
  ansible-playbook ${DOTSPATH}/playbook/main.yml -i ${DOTSPATH}/playbook/hosts

  # Install rust-lang
  echo 'Installing Rust ...'
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

  # Accept license
  sudo xcodebuild -license accept

  # Link config files
  echo 'Linking config files ...'
  ln -s ${DOTSPATH}/.config/ ~/.config
  ln -s ${DOTSPATH}/.gnupg/ ~/.gnupg
  ln -sf ${DOTSPATH}/.z* ~/

  # https://stackoverflow.com/a/13785716
  sudo chmod -R 755 /usr/local/share/zsh

  # Do logging
  terminal-notifier -message 'All done.' -sound Funk
  printf '\xE2\x9C\x94 \e[1;33m All done !!! \u2728 \u2728 \e[m\n'
  printf '\xE2\x9D\x97 \e[1;31m Reboot your computer...\e[m\n'
  read '?Press any key to continue: '

  # Restart to make the setting effective
  sudo reboot
}

install_linux() {
  # Install git
  echo 'Installing git ...'
  sudo apt install git

  # Install dotfiles
  echo 'Installing ken-matsui/dotfiles ...'
  git clone https://github.com/ken-matsui/dotfiles.git
  export DOTSPATH="$(cd $(dirname $0); pwd)/dotfiles"

  sudo apt install zsh
  # TODO: chsh

  # starship
  sh -c "$(curl -fsSL https://starship.rs/install.sh)"

  echo 'support for Linux is work in progress'
}

err() {
  echo "$@" >&2
  exit 1
}

main() {
  local _ostype="$(uname -s)"
  case "$_ostype" in
    Darwin)
      install_macos
      ;;

    Linux)
      install_linux
      ;;

    *)
      err "unrecognized OS type: $_ostype"
      ;;
  esac
}

main "$@" || exit 1
