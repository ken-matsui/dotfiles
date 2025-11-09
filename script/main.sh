#!/bin/sh
set -eu

run() {
  echo "Running $1 ..."
  "$1"
}

OS_NAME="$(uname -s)"
if [ "$OS_NAME" = Darwin ]; then
  for file in "$DOTSPATH"/script/macos/*.sh; do
    run $file
  done
elif [ "$OS_NAME" = Linux ]; then
  run "$DOTSPATH"/script/manjaro.sh
fi

for file in "$DOTSPATH"/script/common/*.sh; do
  run $file
done
