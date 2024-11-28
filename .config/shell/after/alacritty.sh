#!/usr/bin/env sh

if command_exists alacritty; then
  # Disable icon bouncing (cf. https://github.com/alacritty/alacritty/pull/4304)
  printf '\e[?1042l'
fi
