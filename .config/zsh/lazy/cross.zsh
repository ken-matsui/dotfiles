if (( $+commands[brew] )); then
  export CC_x86_64_unknown_linux_musl="$HOMEBREW_PREFIX/bin/x86_64-unknown-linux-musl-gcc"
  export CXX_x86_64_unknown_linux_musl="$HOMEBREW_PREFIX/bin/x86_64-unknown-linux-musl-g++"
  export AR_x86_64_unknown_linux_musl="$HOMEBREW_PREFIX/bin/x86_64-unknown-linux-musl-ar"
  export CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_LINKER="$CC_x86_64_unknown_linux_musl"
fi
