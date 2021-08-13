# dotfiles

## Installation

```sh
$ zsh -c "$(curl -fsSL https://dot.matken.jp)"
```

## Tasks after the installation

### Applications

* TOEFL Official Guide
* [Little Fingers](https://shauninman.com/archive/2017/02/04/little_fingers)
* [Alacritty (manual build for m1)](https://github.com/ken-matsui/dotfiles/issues/53)

### Settings

#### System Preferences

* https://github.com/ken-matsui/dotfiles/issues

#### Dropbox

1. Log into Dropbox
1. `defaults write com.apple.finder NewWindowTargetPath file://~/Dropbox/`

#### GnuPG

Download private.gpg from 1Password, then execute the following command.

```sh
$ gpg --import private.gpg
```

#### RunCat

1. General -> Startup: Launch RunCat at login
1. Indications -> Turn all of them on

#### Mendeley

macOSアプリの開いてすぐの、All Documentsの隣、Edit Settingsをクリック
Synchronize attatched filesのチェックを外す（MendeleyのCloudと同期しない）
Save & Syncで変更を保存

1. In menu bar, click `Mendeley Desktop` -> `Preferences` -> `File Organizer`.
1. Check the box of `Organize my files`.
1. Type `/Users/matken/Dropbox/Documents/Papers` into `Copy files to:` sention.
1. Check the box of `Rename document files`.
1. Chenge to `Year Title` in `File name:` section.
1. Click `OK` to save the changes.
