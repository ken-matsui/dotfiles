#!/bin/bash
set -eu

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
cargo install cargo-update cargo-cache suggest-command-not-found
