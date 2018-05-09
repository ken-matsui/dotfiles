#!/bin/bash

ENVDIR="${DOTSPATH}/scripts/dmgs"
for file in $( ls $ENVDIR ); do
	bash ${ENVDIR}/${file}
done


