if (( $+commands[brew] )); then
  # Completions
  FPATH=$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH

  # Local variable
  HOMEBREW_PREFIX=$(brew --prefix)
fi
