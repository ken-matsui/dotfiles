#!/usr/bin/env sh

if command_exists trash; then
  alias rm='trash'
fi
