#!/bin/zsh

cd ~/

echo 'U2FsdGVkX185GXqQnfcFYnaC5oMyiEXeIhQDnOtitu3b8tTx6Sjm46DGD5EAVypl
akUtjX4brM31joIfy7fjpf7YFdh3VvSmY4o6X48fvjNp4SOVGT1JFTs8Qm1FbdX9
wVhm5sCzvJHcxZBHv+ixcgXt7VV8WX5J01RmjnJ/naZJZ7lvjMk/FihGRZZnq3YH
bbB8zvgXmoOythc2GNaSubFR8RKVJVylIVSrsskeL+xVbSsNrNJnBAkAV9Ostn85
utNpTX7/oou0O01k3jPz5l2CN4DskWqBVjgIK/+hy72+LhbszHQ5/V8nFMTf8eCl
JfHIYt50dnLp9ybGUuBC1wNOwfmV9gr1RQA7Z4d/yw4b7+IwETQGfD+XbHvTydby
/2Mal1u8UFgDaDooFYDGhvZFfe0hsVbJbJWWy8IgfmksOO4DNFFaXk0faPgrHkTr
Fqfogf2MqK44GsiwPA/Or+igzFaEjIgGbbqQYW3a8lIjEewI6MwCZFvHN4uBbxUF
qTDvx0x8XGOryHRFMrZsjgkw3C4yGilHegdq6Zy2jBYfNSBSpVLMOp03TGgONTYg
lDs9N35AWhVwB9i8GCf7a1Dj8LKD323GM7KCllG+qm9w2uPjOS81YjsuOhZTGkLZ' \
| openssl enc -d -des -base64 -k 'dotfiles!!!'

# Ask for the administrator password upfront
printf 'Password for your PC [\e[32m?\e[m] ' && sudo -v
# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

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
brew install git 1>/dev/null

# Install dotfiles
echo 'Installing ken-matsui/dotfiles ...'
git clone https://github.com/ken-matsui/dotfiles.git
export DOTSPATH="$(cd $(dirname $0); pwd)/dotfiles"

# Install ansible (and accompany some of it)
echo 'Installing ansible ...'
brew install ansible 1>/dev/null
ansible-playbook ${DOTSPATH}/playbook/main.yml -i ${DOTSPATH}/playbook/hosts

# Install rust-lang
echo 'Installing Rust ...'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y 1>/dev/null

# Accept license
sudo xcodebuild -license accept

# config
echo 'Linking config files ...'
ln -s ${DOTSPATH}/.config/ ~/.config
ln -sf ${DOTSPATH}/.z* ~/

# https://stackoverflow.com/a/13785716
sudo chmod -R 755 /usr/local/share/zsh

# Logging.
terminal-notifier -message 'All done.' -sound Funk
printf '\xE2\x9C\x94 \e[1;33m All done !!! \u2728 \u2728 \e[m\n'
printf '\xE2\x9D\x97 \e[1;31m Reboot your computer...\e[m\n'
read '?Press any key to continue: '

# Restart to make the setting effective.
sudo reboot
