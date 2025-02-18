<div align="center">

# Dotfiles

|             |                                           |
| ----------- | :---------------------------------------: |
| Terminal    | Alacritty                                 |
| Multiplexer | Tmux                                      |
| Shell       | Zsh                                       |
| Prompt      | Starship                                  |
| Editor      | Vim / Neovim                              |
| Theme       | Material Deep Ocean                       |
| Fonts       | JetBrains Mono Nerd (for everything else) |

</div>

## Installation

### Config-only Installation (recommended)

```sh
cd ~
git clone https://github.com/ken-matsui/dotfiles.git
./dotfiles/setup/common/config.sh minimal
```

### Full Installation (only on macOS or Manjaro Sway)

Use this way only when you have a fresh environment.

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ken-matsui/dotfiles/main/install.sh)"
```

### Manual Font Installation (if necessary)

#### JetBrains Mono Nerd

```sh
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip

mkdir -p ~/.local/share/fonts
mv *.ttf ~/.local/share/fonts

fc-cache -f -v
fc-list | grep JetBrains
```
