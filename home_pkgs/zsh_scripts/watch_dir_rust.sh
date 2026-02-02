#!/bin/zsh

CURRENT=$(tree)
PRIOR="$CURRENT"
clear && tree -C -I "target"

while true; do
	CURRENT=$(tree -C)
	if [[ "$CURRENT" != "$PRIOR" ]]; then
		PRIOR="$CURRENT"
		clear && tree -C -I "target"
	fi
done
