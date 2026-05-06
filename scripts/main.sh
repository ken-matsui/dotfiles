#!/bin/sh
set -eu

run() {
  echo "Running $1 ..."
  "$1"
}

OS_NAME="$(uname -s)"
if [ "$OS_NAME" = Darwin ]; then
  for file in "$DOTSPATH"/scripts/macos/*.sh; do
    run $file
  done
fi

for file in "$DOTSPATH"/scripts/common/*.sh; do
  run $file
done
