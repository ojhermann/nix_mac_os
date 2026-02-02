#!/bin/zsh

if ! git rev-parse --git-dir >/dev/null 2>&1; then
	print -P "%F{green}not a git repository%f"
	exit 0
fi

CURRENT="C"
PRIOR="P"
while true; do
	if [[ "$CURRENT" != "$PRIOR" ]]; then
		clear && git status --short
		PRIOR=$CURRENT
	fi
	CURRENT=$(git status --short)
done
