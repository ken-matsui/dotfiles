#!/bin/sh
set -eu

sudo pacman -Syu
sudo pacman -S \
  python dbus-python fakeroot python-gpgme patch openssh \
  alacritty discord docker \
  ttf-jetbrains-mono-nerd \
  perl-io-socket-ssl perl-authen-sasl perl-mime-tools \  # for git send-email
  atuin \
  bat \
  brave-browser \
  python-black \
  boost \
  clang \
  cmake \
  ctags \
  dejagnu python-unidiff python-gitpython \  # for GCC dev
  fd \
  ffmpeg \
  fprintd \
  gcc \
  github-cli \
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
  neovim \
  nodejs yarn \
  perf \
  power-profiles-daemon \
  python-poetry \
  rust \
  starship \
  tmux \
  valgrind \
  yt-dlp

pamac build \
  1password 1password-cli \
  signal-desktop \
  standardnotes-desktop \
  topgrade \

chsh -s "$(which zsh)"
fprintd-enroll
