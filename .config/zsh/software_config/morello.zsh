if [[ "$OSTYPE" == darwin* ]]; then
  export CLANG=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
else
  export CLANG=clang
fi
