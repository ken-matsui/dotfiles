if (( $+commands[brew] )) && [[ "$OSTYPE" == darwin* ]]; then
  # Google Cloud SDK (gcloud command)
  source $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  source $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi
