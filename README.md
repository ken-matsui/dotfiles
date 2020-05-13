# dotfiles

## HOW TO INSTALL
:warning: This script does not guarantee processing when some files already exist.

e.g. ~/.ssh, ~/.config/nvim, ...


Please exec this command on Terminal.
```:Terminal.app
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/matken11235/dotfiles/master/install.sh)"
```
### Tasks after that
#### Setting
* iTerm2 -> preferences -> Load preferences from a custom folder or URL: ~/dotfiles/config/iterm2 ↩︎Enter
* IntelliJ IDEA -> Import Settings: ~/dotfiles/config/IntelliJIdea2018.1/settings.jar
* CLion -> Import Settings: ~/dotfiles/config/CLion2018.1/settings.jar
* Mendeley ->

macOSアプリの開いてすぐの，All Documentsの隣，Edit Settingsをクリック
Synchronize attatched filesのチェックを外す（MendeleyのCloudと同期しない）
Save & Syncで変更を保存

macのツールバーから，Mendeley Desktop -> Preferences
File Organizer -> Organize my files にチェックを入れる．
Copy files to: /Users/matken/Dropbox/Papers にセットする．

さらに下の，Rename document files にチェックを入れる．
File name: Year Title に変更する．


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
aws configure set aws_access_key_id $aws_access_key
aws configure set aws_secret_access_key $aws_secret_key
aws configure set default.region ${aws_region:-'ap-northeast-1'}
```

```bash
ln -s ~/dotfiles/config/LaunchAgents/auto-commit.plist ~/Library/LaunchAgents/auto-commit.plist
launchctl load ~/Library/LaunchAgents/auto-commit.plist
```

## TODO
* **VSCode config file**
