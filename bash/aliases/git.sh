#!/bin/bash
#set -euo pipefail

alias gs='git status'
alias gd='git diff'
alias gpl='git pull'
alias gps='git push'
alias gc='git commit -m'
alias ga='git add'

complete -F _complete_alias gs
complete -F _complete_alias gd
complete -F _complete_alias gpl
complete -F _complete_alias gps
complete -F _complete_alias gco
complete -F _complete_alias gc
complete -F _complete_alias ga


function gb() {
  # Only output color if the command isn't being piped.
  if [ -t 1 ]; then
    COLOR="always"
  else
    COLOR="auto"
  fi
  
  git branch \
    --all \
    --color="$COLOR" \
    --sort=authordate \
    --format="%(color:blue)%(authordate:relative);%(color:red)%(authorname);%(color:white)%(color:bold)%(refname:short)" \
    "$@" \
    | column -s ";" -t
}

function gbd() {
  git checkout master; 
  git fetch --prune; 
  branchesToDelete=$(git branch -vv | grep ': gone' | awk '{print $1}')
  for branch in $branchesToDelete; do
    git branch -D "$branch"
  done
}

function gco() {
  if [[ "$1" == "mater" ]]; then
    command git checkout master "${@:2}"
  else
    command git checkout "$@"
  fi
}
