# dotfiles

## HOW TO INSTALL
:warning: This script does not guarantee processing when some files already exist.

e.g. ~/.ssh, ~/.config/nvim, ...


Please exec this command on Terminal.
```:Terminal.app
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/matken11235/dotfiles/master/install.sh)"
```
### Tasks after that
#### Install
* MATLAB (by Ritsumeikan univ.)
* Microsoft office (by Ritsumeikan univ.)
* McAfee (by Ritsumeikan univ.)
#### Setting
* iTerm2 -> preferences -> Load preferences from a custom folder or URL: ~/dotfiles/config/iterm2 ↩︎Enter
* IntelliJ IDEA -> Import Settings: ~/dotfiles/config/IntelliJIdea2018.1/settings.jar
* CLion -> Import Settings: ~/dotfiles/config/CLion2018.1/settings.jar

#### Dropbox
* rm -rf ~/.ssh && ln -s ~/Dropbox/ssh ~/.ssh
* kr pair

#### aws-cli
```bash
aws configure set aws_access_key_id $aws_access_key
aws configure set aws_secret_access_key $aws_secret_key
aws configure set default.region ${aws_region:-'ap-northeast-1'}
```


## TODO
* **VSCode config file**

