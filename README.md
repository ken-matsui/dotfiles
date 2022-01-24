# dotfiles

## Installation

```sh
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ken-matsui/dotfiles/main/install.sh)"
```

## Additional Settings

### System Preferences

* https://github.com/ken-matsui/dotfiles/issues

### Dropbox

1. Log into Dropbox
1. `defaults write com.apple.finder NewWindowTargetPath file://~/Dropbox/`

### GnuPG

Download private.gpg from 1Password, and then execute the following command.

```sh
gpg --import private.gpg
```

### RunCat

1. General -> Startup: Launch RunCat at login
1. Indications -> Turn all of them on
