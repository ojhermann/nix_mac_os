#!/bin/zsh
  
setopt prompt_subst

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'

function git_color_prompt() {
	if [[ -n "$vcs_info_msg_0_" ]]; then 
		if git status --porcelain | grep -q '^[ MADRCU?]'; then
			echo '%F{red}'
			else
      echo '%F{green}'
    fi
  fi
}

function parse_git_branch() {
	 local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	 if [[ -n "$branch" ]]; then
	 	echo "[⎇ ${branch}]"
	 fi
}

RPROMPT='$(git_color_prompt)$(parse_git_branch)%f'
