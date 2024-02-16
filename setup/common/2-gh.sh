#!/bin/bash
set -eu

brew install gh

gh auth login
gh ext install seachicken/gh-poi
