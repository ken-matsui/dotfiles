#!/bin/bash
set -eu

# https://github.com/James-Yu/LaTeX-Workshop/issues/376#issuecomment-398591211

sudo cpan Log::Log4perl
sudo cpan Log::Dispatch
sudo cpan YAML::Tiny
sudo cpan File::HomeDir
sudo cpan Unicode::GCString
