#!/bin/bash
set -eu

for file in ${DOTSPATH}/setup/common/*.sh; do
  echo "Running $file ..."
  bash $file
done

if [[ "$OSTYPE" == darwin* ]]; then
  for file in ${DOTSPATH}/setup/macos/*.sh; do
    echo "Running $file ..."
    bash $file
  done
elif [[ "$OSTYPE" == linux* ]]; then
  for file in ${DOTSPATH}/setup/ubuntu/*.sh; do
    echo "Running $file ..."
    bash $file
  done
fi
