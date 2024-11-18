<div align="center">

# Dotfiles

|             |                                                                                       |
| ----------- | :-----------------------------------------------------------------------------------: |
| OS          | macOS / Manjaro Sway                                                                  |
| Terminal    | Alacritty                                                                             |
| Multiplexer | Tmux                                                                                  |
| Shell       | Zsh                                                                                   |
| Prompt      | Starship                                                                              |
| Editor      | Vim / Neovim                                                                          |
| Theme       | Material Deep Ocean                                                                   |
| Fonts       | Source Code Pro for Powerline (for tmux)<br>JetBrains Mono Nerd (for everything else)  |

</div>

## Benchmarks

https://ken-matsui.github.io/dotfiles/dev/bench/

## Installation

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ken-matsui/dotfiles/main/install.sh)"
```

### Individual (non-intrusive) Installation

```sh
cd ~
git clone https://github.com/ken-matsui/dotfiles.git
ln -s ~/dotfiles/.config/nvim ~/.config/nvim  # directory
ln -s ~/dotfiles/.config/starship.toml ~/.config/starship.toml  # file
ln -s ~/dotfiles/.ssh/config ~/.ssh/config  # ssh
ln -s ~/dotfiles/.config/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json  # VSCode on macOS
ln -s ~/dotfiles/.config/Code/User/keybindings.json ~/.config/Code/User/keybindings.json  # VSCode on Linux
ln -s ~/dotfiles/.Brewfile ~/.Brewfile  # Homebrew on macOS
ln -s ~/dotfiles/.bash_profile ~/.bash_profile
brew bundle --global
```

## Additional Settings

### Both OS

#### 1Password

* Settings -> Developer -> Enable `Use the SSH agent`
* Settings -> Developer -> Enable `Integrate with 1Password CLI`

### macOS

#### System Settings

* System Settings -> trackpad -> Trackpad speed: Fast
* System Settings -> Keyboard -> Keyboard -> Modifier Keys -> Caps Lock Key -> Control
* System Settings -> Dock & Menu Bar -> Spotlight -> Show in Menu Bar -> disable
* System Settings -> Dock & Menu Bar -> Wi-Fi -> Show in Menu Bar -> disable
* System Settings -> Dock & Menu Bar -> Bluetooth -> Show in Menu Bar -> disable
* System Settings -> Dock & Menu Bar -> Battery -> Show Percentage
* System Settings -> Dock & Menu Bar -> Clock -> Show date -> `always`

#### Things 3

* Settings -> Quick Entry -> Enable shortcut for Quick Entry -> <kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd>

### Manjaro (TODOs)

* SSH
  * Copy `public key` in 1Password to `~/.ssh/authorized_keys`
  * Link `sshd_config.d/*` to `/etc/ssh/sshd_config.d/`
  * sudo systemctl start sshd.service

* Find trash command
  * https://unix.stackexchange.com/q/42757
  * https://github.com/andreafrancia/trash-cli/
  * https://github.com/nateshmbhat/rm-trash

### Ubuntu (TODO: migrate to Manjaro)

#### Settings

* Keyboard -> Keyboard Shortcuts -> View and Customize Shortcuts -> Typing -> Switch to next input source -> <kbd>Ctrl</kbd> + <kbd>Space</kbd> (automatically applies to `Switch to previous input source`: <kbd>Alt</kbd> + <kbd>Ctrl</kbd> + <kbd>Space</kbd>)
* Keyboard -> Keyboard Shortcuts -> View and Customize Shortcuts -> Navigation -> Move to workspace on the left -> <kbd>Super</kbd> + <kbd>Left</kbd>.
* Keyboard -> Keyboard Shortcuts -> View and Customize Shortcuts -> Navigation -> Move to workspace on the right -> <kbd>Super</kbd> + <kbd>Right</kbd>.

#### Gnome Tweaks

* Keyboard & Mouse -> Mouse Click Emulation -> Enable `Fingers`

#### Remap Keys

* Open `input-remapper`
* `Prior` (`PageUp`) -> `KEY_LEFT`
* `Next` (`PageDown`) -> `KEY_RIGHT`

#### Manual Font Installation

##### JetBrains Mono Nerd

```sh
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip

mkdir -p ~/.local/share/fonts
mv *.ttf ~/.local/share/fonts

fc-cache -f -v
fc-list | grep JetBrains
```

##### Source Code Pro for Powerline

```sh
cd /tmp
git clone https://github.com/powerline/fonts.git
cd fonts/SourceCodePro

mkdir -p ~/.local/share/fonts
mv *.otf ~/.local/share/fonts

fc-cache -f -v
fc-list | grep 'Source Code Pro'
```
