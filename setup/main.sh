#!/bin/sh
set -eu

run() {
  echo "Running $1 ..."
  "$1"
}

if [ "$(uname)" = Darwin ]; then
  for file in "$DOTSPATH"/setup/macos/*.sh; do
    run $file
  done
elif [ "$(uname)" = Linux ]; then
  run "$DOTSPATH"/setup/manjaro.sh
fi

for file in "$DOTSPATH"/setup/common/*.sh; do
  run $file
done
