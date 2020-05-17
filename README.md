# dotfiles

## Installation

```:Terminal.app
$ zsh -c "$(curl -fsSL https://dot.matken.jp)"
```

## Tasks after that

### Applications

* Affinity Designer
* TOEFL Official Guide

### Settings

#### Dropbox
1. Log into Dropbox
1. `rm -rf ~/.ssh && ln -s ~/Dropbox/Private/ssh ~/.ssh`
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
macOSアプリの開いてすぐの，All Documentsの隣，Edit Settingsをクリック
Synchronize attatched filesのチェックを外す（MendeleyのCloudと同期しない）
Save & Syncで変更を保存

macのツールバーから，Mendeley Desktop -> Preferences
File Organizer -> Organize my files にチェックを入れる．
Copy files to: /Users/matken/Dropbox/Papers にセットする．

さらに下の，Rename document files にチェックを入れる．
File name: Year Title に変更する．
