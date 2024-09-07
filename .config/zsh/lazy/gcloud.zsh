if [[ $+commands[brew] -eq 1 && "$OSTYPE" == darwin* ]]; then
  local cloud_sdk_path="$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"

  if [[ -d "$cloud_sdk_path" ]]; then
    # Google Cloud SDK (gcloud command)
    source "$cloud_sdk_path/completion.zsh.inc"
    source "$cloud_sdk_path/path.zsh.inc"
  fi
fi
