if (( $+commands[brew] == 0 )); then
  # https://stackoverflow.com/a/3666941
  return
fi

##################################
# Taps
##################################
brewp homebrew/cask-fonts --tap  # for font-jetbrains-mono-nerd-font
# brewp hashicorp/tap --tap  # for vault
brewp messense/macos-cross-toolchains --tap  # for x86_64-unknown-linux-musl

##################################
# Normal packages
##################################
brewp asciinema
# brewp awscli
brewp bat
brewp boost
# brewp boost-python
brewp clang-format
brewp cmake
brewp cowsay
brewp curl
brewp dog
# brewp elixir
# brewp elm
# brewp erlang
brewp ffmpeg  # for youtube-dl
brewp fortune
brewp gh
# brewp ghc
brewp gibo  # fast access to .gitignore boilerplates
brewp git-delta
brewp git-interactive-rebase-tool
brewp go
brewp graphviz
brewp gzip
# brewp httrack
# brewp hyperfine
brewp jq
brewp ripgrep
# brewp kops
# brewp kr
# brewp kubectl
# brewp libarchive
# brewp libgit2
brewp llvm  # clangd, clang-format, clang-tidy
brewp lolcat
brewp lsd
# brewp mysql  # for mysqlclient of Python
brewp ninja
# brewp neofetch
brewp neovim
brewp peco
brewp python
brewp starship
brewp subversion  # for font-source-code-pro-for-powerline
# brewp terraform
brewp topgrade
brewp trash
brewp tree
# brewp vault
# brewp valgrind
# brewp wapm
# brewp wasmer
brewp wget
brewp wrk
brewp x86_64-unknown-linux-musl  # This also works on m1 mac
brewp youtube-dl
brewp zellij

##################################
# Cask packages
##################################
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brewp alacritty --cask
# brewp balenaetcher --cask  # Flash OS images to SD cards & USB drives, safely and easily.
brewp bartender --cask
# brewp clickup --cask
brewp deepl --cask
brewp devtoys --cask
brewp discord --cask
brewp docker --cask
# brewp drawio --cask
brewp dropbox --cask
# brewp figma --cask
# brewp firefox --cask
brewp font-jetbrains-mono-nerd-font --cask  # for alacritty
brewp font-source-code-pro-for-powerline --cask
# brewp fritzing --cask
brewp google-chrome --cask
brewp google-cloud-sdk --cask
brewp grammarly-desktop --cask
# brewp imobie-m1-app-checker --cask
brewp jetbrains-toolbox --cask
brewp keybase --cask
# brewp lens --cask
# brewp mendeley --cask
brewp mimestream --cask
# brewp mysqlworkbench --cask
# brewp multipass --cask
# brewp notion --cask
# brewp numi --cask
# brewp parallels --cask
# brewp processing --cask
# brewp postman --cask
brewp protonvpn --cask
brewp raycast --cask
brewp sf-symbols --cask
brewp signal --cask
# brewp sketch --cask
brewp swish --cask
# brewp tor-browser --cask
brewp visual-studio-code --cask
# brewp xcodes --cask
brewp zoom --cask
brewp zulip --cask

##################################
# Install packages
##################################
brewp install
