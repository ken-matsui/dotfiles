# dotfiles

Dotfiles for macOS using Zsh, Zellij, and Alacritty

<img width="975" alt="ScreenShot" src="https://user-images.githubusercontent.com/26405363/150774356-1bb319e4-4b7f-4a1f-9b59-a165111b111c.png">

## Installation

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ken-matsui/dotfiles/main/install.sh)"
```

## Additional Settings

### Both OS

#### 1Password

* Settings -> Developer -> Enable `Use the SSH agent`

### macOS

#### System Settings

* System Settings -> trackpad -> Trackpad speed: Fast
* System Settings -> Keyboard -> Keyboard -> Modifier Keys -> Caps Lock Key -> Control
* System Settings -> Dock & Menu Bar -> Automatically hide and show the Dock
* System Settings -> Dock & Menu Bar -> Spotlight -> Show in Menu Bar -> disable
* System Settings -> Dock & Menu Bar -> Wi-Fi -> Show in Menu Bar -> disable
* System Settings -> Dock & Menu Bar -> Bluetooth -> Show in Menu Bar -> disable
* System Settings -> Dock & Menu Bar -> Battery -> Show Percentage
* System Settings -> Dock & Menu Bar -> Clock -> Show date -> `always`

### Ubuntu

* Run `fprintd-enroll` on the terminal app to enable fingerprint authentication.
* Run `sudo pam-auth-update` (https://askubuntu.com/a/1040609)

* Install [Ulauncher](https://ulauncher.io/).
* Install Dropbox
* Install Zoom
* Install Google Chrome
  ```shell
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  ```
* Install the following software:
  ```shell
  sudo snap install alacritty --classic
  sudo snap install discord
  sudo snap install docker
  sudo snap install brave
  sudo snap install standard-notes
  sudo snap install code --classic
  sudo snap install intellij-idea-ultimate --classic
  sudo snap install clion --classic
  sudo snap install webstorm --classic
  sudo snap install pycharm-professional --classic
  
  sudo apt install gnome-tweaks
  sudo apt install gnome-shell-extensions
  sudo apt install gnome-shell-extension-manager
  ```
* Install [RunCat](https://extensions.gnome.org/extension/2986/runcat/)
  * TODO: with https://github.com/brunelli/gnome-shell-extension-installer
* Install 1Password
  ```shell
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
  sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
  curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
  sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
  sudo apt update && sudo apt install 1password
  ```

* Uninstall the following software:
  ```shell
  sudo snap remove firefox
  sudo apt purge thunderbird
  sudo apt purge aisleriot gnome-mahjongg gnome-mines gnome-sudoku
  ```

* TODO: Find clipboard manager
* TODO: Swipe back on browsers (https://kaigo.medium.com/mac-like-gestures-on-ubuntu-20-04-dell-xps-15-7ea6e3be7f76)
* TODO: Find trash command
  * https://unix.stackexchange.com/q/42757
  * https://github.com/andreafrancia/trash-cli/
  * https://github.com/nateshmbhat/rm-trash

#### Gnome Tweaks

* Keyboard & Mouse -> Additional Layout Options -> Caps Lock behavior -> Enable `Make Caps Lock an additional Ctrl`
* Top Bar -> Clock -> Enable `Weekday and Date`
* Window Titlebars -> Titlebar Buttons -> Placement -> Click `Left`
* Keyboard & Mouse -> Mouse -> Disable `Middle Click Paste`
