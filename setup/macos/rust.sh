#!/bin/sh
set -eu

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
