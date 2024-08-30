#!/bin/bash
set -eu

sudo pacman -Syu
sudo pacman -S \
  python dbus-python fakeroot python-gpgme patch openssh \
  alacritty discord docker \
  ttf-jetbrains-mono-nerd powerline-fonts \
  perl-io-socket-ssl perl-authen-sasl perl-mime-tools \  # for git send-email
  atuin \
  bat \
  python-black \
  boost \
  clang \
  cmake \
  code \
  ctags \
  dejagnu python-unidiff python-gitpython \  # for GCC dev
  fd \
  ffmpeg \
  fprintd \
  gcc \
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
  nodejs yarn \
  perf \
  power-profiles-daemon \
  python-poetry \
  rust \
  starship \
  tmux \
  valgrind \
  w3m \
  yt-dlp

pamac build \
  1password 1password-cli \
  google-chrome \
  standardnotes-desktop \
  topgrade \
  google-java-format

chsh -s $(which zsh)
fprintd-enroll
