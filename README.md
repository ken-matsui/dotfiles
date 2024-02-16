<div align="center">

# Dotfiles

![ScreenShot 4](https://github.com/ken-matsui/dotfiles/assets/26405363/9a973a6c-9e46-4e4d-9f8d-a4dbf43d6bde)

|             |                     |
| ----------- | :-----------------: |
| OS          | macOS / Ubuntu      |
| Terminal    | Alacritty           |
| Multiplexer | Tmux                |
| Shell       | Zsh                 |
| Prompt      | Starship            |
| Editor      | Vim / Neovim        |
| Theme       | Material Deep Ocean |
| Font        | JetBrains Mono Nerd |

</div>

## Performance

### Zsh load time

```console
$ hyperfine 'zsh -i -c exit' --warmup 5
Benchmark 1: zsh -i -c exit
  Time (mean ± σ):     300.0 ms ±   1.1 ms    [User: 105.5 ms, System: 129.6 ms]
  Range (min … max):   298.0 ms … 301.5 ms    10 runs
```

```console
$ # comment out `zmodload zsh/zprof` on .zshrc
$ zprof
```

### Neovim load time

#### Include lazy loaded plugins

```console
$ hyperfine 'nvim --headless "+Lazy! sync" +qa' --warmup 5
Benchmark 1: nvim --headless "+Lazy! sync" +qa
  Time (mean ± σ):     762.3 ms ±  51.8 ms    [User: 563.0 ms, System: 559.6 ms]
  Range (min … max):   672.5 ms … 838.5 ms    10 runs
```

#### Without lazy loaded plugins

```console
$ hyperfine 'nvim +qa' --warmup 5
Benchmark 1: nvim +qa
  Time (mean ± σ):      29.5 ms ±   0.9 ms    [User: 17.2 ms, System: 10.4 ms]
  Range (min … max):    28.1 ms …  33.9 ms    92 runs
```

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
ln -s ~/dotfiles/.config/Code/User/settings.json ~/Library/Application\ Support/Cursor/User/settings.json  # Cursor on macOS
ln -s ~/dotfiles/.config/Code/User/keybindings.json ~/.config/Code/User/keybindings.json  # VSCode on Linux
```

#### On Ubuntu

```sh
ln -s ~/dotfiles/.local/share/alacritty/config.yml ~/.local/share/alacritty/config.yml
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

### Ubuntu

* Install [Ulauncher](https://ulauncher.io/).
* Install Dropbox
* Install Zoom
* Install Google Chrome
  ```shell
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  ```
* Install [RunCat](https://extensions.gnome.org/extension/2986/runcat/)
  * TODO: with https://github.com/brunelli/gnome-shell-extension-installer
* Install 1Password
  ```shell
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
  sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
  curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
  sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
  sudo apt update && sudo apt install 1password
  ```
* Install Ukuu

* TODO: Find clipboard manager
* TODO: Swipe back on browsers (https://kaigo.medium.com/mac-like-gestures-on-ubuntu-20-04-dell-xps-15-7ea6e3be7f76)
* TODO: Find trash command
  * https://unix.stackexchange.com/q/42757
  * https://github.com/andreafrancia/trash-cli/
  * https://github.com/nateshmbhat/rm-trash

#### Settings

* Keyboard -> Keyboard Shortcuts -> View and Customize Shortcuts -> Typing -> Switch to next input source -> <kbd>Ctrl</kbd> + <kbd>Space</kbd> (automatically applies to `Switch to previous input source`: <kbd>Alt</kbd> + <kbd>Ctrl</kbd> + <kbd>Space</kbd>)
* Keyboard -> Keyboard Shortcuts -> View and Customize Shortcuts -> Navigation -> Move to workspace on the left -> <kbd>Super</kbd> + <kbd>Left</kbd>.
* Keyboard -> Keyboard Shortcuts -> View and Customize Shortcuts -> Navigation -> Move to workspace on the right -> <kbd>Super</kbd> + <kbd>Right</kbd>.

#### Ulauncher Preferences

* Hotkey -> <kbd>Super</kbd> (Windows mark) + <kbd>Space</kbd>

#### Gnome Tweaks

* Keyboard & Mouse -> Additional Layout Options -> Caps Lock behavior -> Enable `Make Caps Lock an additional Ctrl`
* Top Bar -> Clock -> Enable `Weekday and Date`
* Window Titlebars -> Titlebar Buttons -> Placement -> Click `Left`
* Keyboard & Mouse -> Mouse -> Disable `Middle Click Paste`
* Keyboard & Mouse -> Mouse Click Emulation -> Enable `Fingers`

#### Remap Keys

* Open `input-remapper`
* `Prior` (`PageUp`) -> `KEY_LEFT`
* `Next` (`PageDown`) -> `KEY_RIGHT`
