if (( $+commands[jenv] )); then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi
