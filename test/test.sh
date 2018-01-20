#!/bin/bash

# if [[ -n `git remote show origin | grep "local out of date"` ]]; then
# 	echo "ok"
# else
# 	echo "no"
# fi

# usage () {
# 	sleep $1
# 	echo $1
# }

# usage 1 &
# usage 5 &

# wait

# usage () {
# 	echo 'ok'
# }
# SCRIPT_DIR=$(cd $(dirname $0); pwd)
# echo "${SCRIPT_DIR%.dotfiles}settings"

# read -p 'ok?: ' ok

declare -a install_list=('brew' 'git' 'anyenv' 'pyenv' 'ndenv' 'exenv' 'goenv' 'ghc' 'mosh' 'mas')
declare -a tmp=()
for cmd in ${install_list[@]}; do
	echo $cmd
	tmp+=($cmd)
done
echo
for cmd in ${tmp[@]}; do
	echo $cmd
done
# for env in `anyenv versions | grep : | awk -F ':' '{print $1}'`; do
# 	newest=`eval $env install -l 2>/dev/null | \
# 		grep -v - | \
# 		grep -v / | \
# 		grep -v dev | \
# 		grep -v b | \
# 		grep -v a | \
# 		awk '{if(m<$1) m=$1} END{print m}'
# 	`
# 	if [[ -n $newest ]]; then
# 		yes 'N' | eval $env install $newest >/dev/null
# 	fi
# done
