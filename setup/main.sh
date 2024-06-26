#!/bin/bash
set -eu

run() {
  echo "Running $1 ..."
  bash $1
}

if [[ "$OSTYPE" == darwin* ]]; then
  for file in ${DOTSPATH}/setup/macos/*.sh; do
    run $file
  done
elif [[ "$OSTYPE" == linux* ]]; then
  run ${DOTSPATH}/setup/manjaro.sh
fi

for file in ${DOTSPATH}/setup/common/*.sh; do
  run $file
done
