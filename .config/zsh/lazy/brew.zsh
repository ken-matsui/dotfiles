if (( $+commands[brew] )); then
  # Local variable
  HOMEBREW_PREFIX=$(brew --prefix)
  # Completions
  FPATH=$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi
