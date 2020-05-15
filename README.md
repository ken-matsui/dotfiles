# dotfiles

## HOW TO INSTALL
:warning: This script does not guarantee processing when some files already exist.

e.g. ~/.ssh, ~/.config/nvim, ...

Please execute this command on Terminal.
```:Terminal.app
$ bash -c "$(curl -fsSL https://dot.matken.jp)"
```

## Tasks after that
### Install
* Affinity Designer
* TOEFL Official Guide

### Setting
#### Mendeley
macOSアプリの開いてすぐの，All Documentsの隣，Edit Settingsをクリック
Synchronize attatched filesのチェックを外す（MendeleyのCloudと同期しない）
Save & Syncで変更を保存

macのツールバーから，Mendeley Desktop -> Preferences
File Organizer -> Organize my files にチェックを入れる．
Copy files to: /Users/matken/Dropbox/Papers にセットする．

さらに下の，Rename document files にチェックを入れる．
File name: Year Title に変更する．

#### RunCat
General -> Startup: Launch RunCat at login
Indications -> Turn all of them on

#### Dropbox
* rm -rf ~/.ssh && ln -s ~/Dropbox/Private/ssh ~/.ssh
* kr pair

https://krypt.co/docs/start/code-signing.html

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


#### aws-cli
```bash
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region ${AWS_DEFAULT_REGION:-'ap-northeast-1'}
```

```bash
ln -s ~/dotfiles/config/LaunchAgents/auto-commit.plist ~/Library/LaunchAgents/auto-commit.plist
launchctl load ~/Library/LaunchAgents/auto-commit.plist
```

## TODO
* **VSCode config file**
