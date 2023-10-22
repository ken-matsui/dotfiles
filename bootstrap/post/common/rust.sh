#!/bin/bash
set -eu

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

cargo install cargo-update
cargo install cargo-cache
cargo install suggest-command-not-found
