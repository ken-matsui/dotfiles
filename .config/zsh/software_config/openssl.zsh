if (( $+commands[brew] )); then
  export PATH="$HOMEBREW_PREFIX/opt/openssl@3/bin:$PATH"
  export LDFLAGS="-L$HOMEBREW_PREFIX/opt/openssl@3/lib"
  export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/openssl@3/include"
fi
