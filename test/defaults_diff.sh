#!/bin/bash
set -e

trap "rm -rf defaults_*.txt" 0

defaults read > defaults_bef.txt
defaults -currentHost read > defaults_currentHost_bef.txt

read -n 1 -s -r -p "Press any key to continue"

defaults read > defaults_aft.txt
defaults -currentHost read > defaults_currentHost_aft.txt

diff defaults_aft.txt defaults_bef.txt
diff defaults_currentHost_aft.txt defaults_currentHost_bef.txt
