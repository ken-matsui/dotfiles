if (( $+commands[brew] )); then
  alias clang-tidy=$HOMEBREW_PREFIX/opt/llvm/bin/clang-tidy
  alias clang-format=$HOMEBREW_PREFIX/opt/llvm/bin/clang-format
fi
