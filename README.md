# dotfiles

## Installation

```:Terminal.app
$ zsh -c "$(curl -fsSL https://dot.matken.jp)"
```

## Tasks after the above command

### Applications

* Affinity Designer
* TOEFL Official Guide

### Settings

#### Dropbox
1. Log into Dropbox
1. `rm -rf ~/.ssh && ln -s ~/Dropbox/Documents/ssh ~/.ssh`
1. `defaults write com.apple.finder NewWindowTargetPath file://~/Dropbox/`

#### krypt.co
```bash
kr pair
```

> https://krypt.co/docs/start/code-signing.html

To enable code signing, run the following command on your paired computer
```bash
kr codesign
```

Follow the instructions to add your PGP public key to GitHub.

Next, test that everything works:
```bash
export GPG_TTY=$(tty); kr codesign test
```

Finally, disable auto sign-off.
```bash
git config --global commit.gpgsign false
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
