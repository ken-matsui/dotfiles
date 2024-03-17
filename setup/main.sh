#!/bin/bash
set -eu

if [[ "$OSTYPE" == darwin* ]]; then
  for file in ${DOTSPATH}/setup/macos/*.sh; do
    echo "Running $file ..."
    bash $file
  done
elif [[ "$OSTYPE" == linux* ]]; then
  for file in ${DOTSPATH}/setup/manjaro/*.sh; do
    echo "Running $file ..."
    bash $file
  done
fi

for file in ${DOTSPATH}/setup/common/*.sh; do
  echo "Running $file ..."
  bash $file
done
