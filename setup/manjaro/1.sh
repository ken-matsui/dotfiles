sudo pacman -Syu
sudo pacman -S \
  python dbus-python fakeroot python-gpgme patch \
  alacritty discord docker \
  ttf-jetbrains-mono-nerd powerline-fonts \
  atuin \
  bat \
  python-black \
  boost \
  cmake \
  fd \
  ffmpeg \
  github-cli \
  git-delta \
  graphviz \
  gzip \
  hyperfine \
  jq \
  ripgrep \
  libarchive \
  libgit2 \
  llvm \  # clangd, clang-format, clang-tidy
  lsd \
  ninja \
  neomutt \
  neovim \
  nodejs \
  python-poetry \
  rust \
  starship \
  tmux \
  ctags \
  w3m \
  yt-dlp
pamac build 1password 1password-cli dropbox slack-desktop google-chrome notesnook topgrade google-java-format zoom
cargo install cargo-update cargo-cache suggest-command-not-found

chsh -s $(which zsh)
