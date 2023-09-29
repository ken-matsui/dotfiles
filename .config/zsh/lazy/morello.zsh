if [[ "$OSTYPE" == darwin* ]]; then
  # export CLANG=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
  export CLANG=/opt/homebrew/opt/llvm/bin/clang
else
  export CLANG=clang
fi
