if (( $+commands[brew] )); then
  export PATH="${HOMEBREW_PREFIX}/opt/openssl@1.1/bin:$PATH"
  export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/openssl@1.1/lib"
  export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/openssl@1.1/include"
fi
