if (( $+commands[brew] )); then
  export PATH=$HOMEBREW_PREFIX/bin:$PATH
  export PATH=$HOMEBREW_PREFIX/opt/python@3.10/libexec/bin:$PATH
fi
