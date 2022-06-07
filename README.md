# dotfiles

Dotfiles for macOS using Zsh, Zellij, and Alacritty

<img width="975" alt="ScreenShot" src="https://user-images.githubusercontent.com/26405363/150774356-1bb319e4-4b7f-4a1f-9b59-a165111b111c.png">

## Installation

```sh
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ken-matsui/dotfiles/main/install.sh)"
```

## Additional Settings

### System Preferences

* https://github.com/ken-matsui/dotfiles/issues

### Dropbox

1. Log in to Dropbox
2. `defaults write com.apple.finder NewWindowTargetPath file://~/Dropbox/`
3. `Preferences` -> `General` -> `Dropbox badge` -> `Never show`

### GnuPG

1. Log in to Keybase.io
2. Click the `edit` button on right of GPG Key
3. Click `Export my private key from Keybase`
4. Enter Keybase.io password
5. Create a `private.pgp` file that contains the exported content
6. Execute `gpg --import private.pgp`

### RunCat

1. General -> Startup: Launch RunCat at login
1. Indications -> Turn all of them on
