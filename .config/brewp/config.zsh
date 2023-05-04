if (( $+commands[brew] == 0 )); then
  # https://stackoverflow.com/a/3666941
  return
fi

##################################
# Taps
##################################
if [[ "$OSTYPE" == darwin* ]]; then
  brewp add homebrew/cask-fonts --tap  # for font-jetbrains-mono-nerd-font
  # brewp hashicorp/tap --tap  # for vault
  brewp add messense/macos-cross-toolchains --tap  # for x86_64-unknown-linux-musl
fi

##################################
# Normal packages
##################################
# brewp add asciinema
# brewp add awscli
brewp add bat
brewp add boost
brewp add clang-format
brewp add cmake
brewp add curl
# brewp add elixir
# brewp add elm
# brewp add erlang
brewp add ffmpeg  # for youtube-dl
brewp add gh
brewp add gibo  # fast access to .gitignore boilerplates
brewp add git-delta
brewp add git-interactive-rebase-tool
brewp add graphviz
brewp add gzip
# brewp add httrack
# brewp add hyperfine
brewp add jq
brewp add ripgrep
# brewp add kops
# brewp add kr
# brewp add kubectl
brewp add libarchive
brewp add libgit2
brewp add llvm  # clangd, clang-format, clang-tidy
brewp add lsd
# brewp add mysql  # for mysqlclient of Python
brewp add ninja
brewp add neovim
brewp add node
# brewp add peco
brewp add poetry
brewp add python
brewp add starship
brewp add subversion  # for font-source-code-pro-for-powerline
# brewp add terraform
brewp add topgrade
if [[ "$OSTYPE" == darwin* ]]; then
  brewp add trash
fi
# brewp add vault
# brewp add valgrind
# brewp add wapm
# brewp add wasmer
brewp add wget
brewp add wrk
if [[ "$OSTYPE" == darwin* ]]; then
  brewp add x86_64-unknown-linux-musl  # This also works on m1 mac
fi
brewp add youtube-dl
brewp add zellij

##################################
# Cask packages
##################################
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# brewp add 1password --cask
brewp add alacritty --cask
# brewp add balenaetcher --cask  # Flash OS images to SD cards & USB drives, safely and easily.
brewp add bartender --cask
brewp add brave-browser --cask
brewp add deepl --cask
brewp add discord --cask
brewp add docker --cask
# brewp add drawio --cask
# brewp add figma --cask
brewp add font-jetbrains-mono-nerd-font --cask  # for alacritty
brewp add font-source-code-pro-for-powerline --cask
brewp add google-chrome --cask
brewp add google-cloud-sdk --cask
brewp add grammarly-desktop --cask
# brewp add imobie-m1-app-checker --cask
brewp add jetbrains-toolbox --cask
# brewp add lens --cask
brewp add logseq --cask
# brewp add mendeley --cask
# brewp add mimestream --cask
# brewp add mysqlworkbench --cask
# brewp add notion --cask
# brewp add parallels --cask
# brewp add postman --cask
brewp add protonvpn --cask
brewp add raycast --cask
# brewp add sf-symbols --cask
# brewp add sketch --cask
brewp add standard-notes --cask
brewp add swish --cask
brewp add visual-studio-code --cask
# brewp add xcodes --cask
brewp add zoom --cask
# brewp add zulip --cask
