#!/bin/bash

ENVDIR="${DOTSPATH}/scripts/dmgs"
for file in $( ls $ENVDIR | grep -v 'main.sh' ); do
	bash ${ENVDIR}/${file}
done


