if (( $+commands[brew] == 0 )); then
  # https://stackoverflow.com/a/3666941
  return
fi

##################################
# Taps
##################################
if [[ "$OSTYPE" == darwin* ]]; then
  brewp homebrew/cask-fonts --tap  # for font-jetbrains-mono-nerd-font
  # brewp hashicorp/tap --tap  # for vault
  brewp messense/macos-cross-toolchains --tap  # for x86_64-unknown-linux-musl
fi

##################################
# Normal packages
##################################
# brewp asciinema
# brewp awscli
brewp bat
brewp boost
brewp clang-format
brewp cmake
brewp curl
# brewp elixir
# brewp elm
# brewp erlang
brewp ffmpeg  # for youtube-dl
brewp gh
brewp gibo  # fast access to .gitignore boilerplates
brewp git-delta
brewp git-interactive-rebase-tool
brewp graphviz
brewp gzip
# brewp httrack
# brewp hyperfine
brewp jq
brewp ripgrep
# brewp kops
# brewp kr
# brewp kubectl
brewp libarchive
brewp libgit2
brewp llvm  # clangd, clang-format, clang-tidy
brewp lsd
# brewp mysql  # for mysqlclient of Python
brewp ninja
brewp neovim
brewp node
# brewp peco
brewp poetry
brewp python
brewp starship
brewp subversion  # for font-source-code-pro-for-powerline
# brewp terraform
brewp topgrade
if [[ "$OSTYPE" == darwin* ]]; then
  brewp trash
fi
# brewp vault
# brewp valgrind
# brewp wapm
# brewp wasmer
brewp wget
brewp wrk
if [[ "$OSTYPE" == darwin* ]]; then
  brewp x86_64-unknown-linux-musl  # This also works on m1 mac
fi
brewp youtube-dl
brewp zellij

##################################
# Cask packages
##################################
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# brewp 1password --cask
brewp alacritty --cask
# brewp balenaetcher --cask  # Flash OS images to SD cards & USB drives, safely and easily.
brewp bartender --cask
brewp brave-browser --cask
brewp deepl --cask
brewp discord --cask
brewp docker --cask
# brewp drawio --cask
# brewp figma --cask
brewp font-jetbrains-mono-nerd-font --cask  # for alacritty
brewp font-source-code-pro-for-powerline --cask
brewp google-chrome --cask
brewp google-cloud-sdk --cask
brewp grammarly-desktop --cask
# brewp imobie-m1-app-checker --cask
brewp jetbrains-toolbox --cask
# brewp lens --cask
brewp logseq --cask
# brewp mendeley --cask
# brewp mimestream --cask
# brewp mysqlworkbench --cask
brewp notion --cask
# brewp parallels --cask
# brewp postman --cask
brewp protonvpn --cask
brewp raycast --cask
# brewp sf-symbols --cask
brewp session --cask
# brewp sketch --cask
brewp standard-notes --cask
brewp swish --cask
brewp visual-studio-code --cask
# brewp xcodes --cask
brewp zoom --cask
# brewp zulip --cask
