# dotfiles

Dotfiles for macOS using Zsh, Zellij, and Alacritty

<img width="975" alt="ScreenShot" src="https://user-images.githubusercontent.com/26405363/150774356-1bb319e4-4b7f-4a1f-9b59-a165111b111c.png">

## Installation

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ken-matsui/dotfiles/main/install.sh)"
```

## Additional Settings

### System Preferences

* System Preference -> trackpad -> Trackpad speed: Fast
* System Preferences -> Keyboard -> Keyboard -> Modifier Keys -> Caps Lock Key -> Control
* System Preference -> Dock & Menu Bar -> Automatically hide and show the Dock
* System Preference -> Dock & Menu Bar -> Spotlight -> Show in Menu Bar -> disable
* System Preference -> Dock & Menu Bar -> Wi-Fi -> Show in Menu Bar -> disable
* System Preference -> Dock & Menu Bar -> Bluetooth -> Show in Menu Bar -> disable
* System Preference -> Dock & Menu Bar -> Battery -> Show Percentage
* System Preference -> Dock & Menu Bar -> Clock -> Show date -> `always`

### Dropbox

1. Log in to Dropbox
2. `defaults write com.apple.finder NewWindowTargetPath file://~/Dropbox/`
3. `Preferences` -> `General` -> `Dropbox badge` -> `Never show`
