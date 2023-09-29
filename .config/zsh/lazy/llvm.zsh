if (( $+commands[brew] )); then
  export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
  alias clang-format=$HOMEBREW_PREFIX/opt/clang-format/bin/clang-format
fi
