#!/bin/zsh

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

# Install dotfiles
echo 'Installing ken-matsui/dotfiles ...'
git clone https://github.com/ken-matsui/dotfiles.git
export DOTSPATH="$(cd $(dirname $0); pwd)/dotfiles"

# Install ansible & mas
echo 'Installing ansible & mas ...'
brew install ansible mas

# Install software that I need
echo 'Running ansible ...'
ansible-playbook ${DOTSPATH}/playbook/main.yml -i ${DOTSPATH}/playbook/hosts

# Accept license
sudo xcodebuild -license accept
