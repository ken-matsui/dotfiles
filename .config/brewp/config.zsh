if (( $+commands[brew] == 0 )); then
  return
fi

##################################
# Taps
##################################
if [[ "$OSTYPE" == darwin* ]]; then
  brewp add homebrew/cask-fonts --tap  # for font-jetbrains-mono-nerd-font
fi

##################################
# Normal packages
##################################
brewp add alpine
brewp add atuin
# brewp add asciinema
# brewp add awscli
brewp add bat
brewp add boost
brewp add clang-format
brewp add cmake
brewp add curl
brewp add fd  # for telescope.nvim
brewp add ffmpeg  # for youtube-dl
brewp add gh
brewp add git-delta
brewp add git-interactive-rebase-tool
brewp add graphviz
brewp add gzip
# brewp add httrack
brewp add hyperfine
brewp add jq
brewp add ripgrep
brewp add libarchive
brewp add libgit2
brewp add llvm  # clangd, clang-format, clang-tidy
brewp add lsd
# brewp add mysql  # for mysqlclient of Python
brewp add ninja
brewp add neovim
brewp add node
brewp add poetry
brewp add python
brewp add starship
brewp add subversion  # for font-source-code-pro-for-powerline
brewp add tmux
brewp add topgrade
if [[ "$OSTYPE" == darwin* ]]; then
  brewp add trash
fi
brewp add universal-ctags
# brewp add valgrind
brewp add wget
brewp add wrk
brewp add youtube-dl

##################################
# Cask packages (only for macOS)
##################################
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brewp add 1password --cask
brewp add alacritty --cask
# brewp add balenaetcher --cask  # Flash OS images to SD cards & USB drives, safely and easily.
brewp add bartender --cask
brewp add brave-browser --cask
brewp add deepl --cask
brewp add discord --cask
brewp add docker --cask
# brewp add figma --cask
brewp add font-jetbrains-mono-nerd-font --cask  # for alacritty
brewp add font-source-code-pro-for-powerline --cask
brewp add google-chrome --cask
brewp add google-cloud-sdk --cask
brewp add grammarly-desktop --cask
brewp add jetbrains-toolbox --cask
brewp add logseq --cask
brewp add mactex-no-gui --cask
# brewp add mendeley --cask
# brewp add notion --cask
# brewp add postman --cask
brewp add protonvpn --cask
brewp add raycast --cask
# brewp add sf-symbols --cask
# brewp add sketch --cask
brewp add standard-notes --cask
brewp add swish --cask
brewp add visual-studio-code --cask
brewp add zoom --cask
# brewp add zulip --cask
