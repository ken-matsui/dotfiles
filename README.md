<div align="center">

# Dotfiles

|             |                      |
| ----------- | :------------------: |
| OS          | macOS / Manjaro Sway |
| Terminal    | Alacritty            |
| Multiplexer | Tmux                 |
| Shell       | Zsh                  |
| Prompt      | Starship             |
| Editor      | Vim / Neovim         |
| Theme       | Material Deep Ocean  |
| Font        | JetBrains Mono Nerd  |

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
