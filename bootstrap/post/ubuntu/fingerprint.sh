#!/bin/bash
set -eu

fprintd-enroll
sudo pam-auth-update  # https://askubuntu.com/a/1040609
