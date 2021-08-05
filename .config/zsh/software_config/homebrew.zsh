if (( $+commands[brew] )); then
  # Completions
  FPATH=$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH
  autoload -Uz compinit
  compinit

  # Local variable
  HOMEBREW_PREFIX=$(brew --prefix)
fi
