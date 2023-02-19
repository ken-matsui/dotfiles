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
* Install the following software:
  ```shell
  sudo snap install 1password
  sudo snap install discord
  sudo snap install docker
  sudo snap install brave
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
