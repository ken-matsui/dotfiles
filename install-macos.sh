#!/bin/bash

echo 'Installing ansible & mas ...'
brew install ansible mas

# Install software that I need
echo 'Running ansible ...'
ansible-playbook ${DOTSPATH}/playbook/main.yml -i ${DOTSPATH}/playbook/hosts

# Accept license
sudo xcodebuild -license accept
