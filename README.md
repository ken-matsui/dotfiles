# dotfiles

Dotfiles for macOS using Zsh, Zellij, and Alacritty

<img width="975" alt="ScreenShot" src="https://user-images.githubusercontent.com/26405363/150774356-1bb319e4-4b7f-4a1f-9b59-a165111b111c.png">

## Installation

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ken-matsui/dotfiles/main/install.sh)"
```

## Additional Settings

### macOS

#### System Preferences

* System Preference -> trackpad -> Trackpad speed: Fast
* System Preferences -> Keyboard -> Keyboard -> Modifier Keys -> Caps Lock Key -> Control
* System Preference -> Dock & Menu Bar -> Automatically hide and show the Dock
* System Preference -> Dock & Menu Bar -> Spotlight -> Show in Menu Bar -> disable
* System Preference -> Dock & Menu Bar -> Wi-Fi -> Show in Menu Bar -> disable
* System Preference -> Dock & Menu Bar -> Bluetooth -> Show in Menu Bar -> disable
* System Preference -> Dock & Menu Bar -> Battery -> Show Percentage
* System Preference -> Dock & Menu Bar -> Clock -> Show date -> `always`

### Ubuntu

* Run `fprintd-enroll` on the terminal app to enable fingerprint authentication.
* Install [Ulauncher](https://ulauncher.io/).
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
  ```
