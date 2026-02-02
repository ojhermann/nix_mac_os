#!/bin/zsh

CURRENT=$(tree -C -a --gitignore -I ".git")
PRIOR="$CURRENT"
clear && tree -C -a --gitignore -I ".git"

while true; do
	CURRENT=$(tree -C -a --gitignore -I ".git")
	if [[ "$CURRENT" != "$PRIOR" ]]; then
		PRIOR="$CURRENT"
		clear && tree -C -a --gitignore -I ".git"
	fi
done
