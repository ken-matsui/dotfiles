if (( $+commands[brew] )); then
  export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
  export PATH="$HOMEBREW_PREFIX/opt/clang-format/bin:$PATH"
fi
