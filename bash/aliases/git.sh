#!/bin/bash
#set -euo pipefail

alias gs='git status'
alias gd='git diff'
alias gpl='git pull'
alias gps='git push'

function gco() {
  git checkout $@
}
function gc() {
  git commit -m "$1"
}
function ga() {
  git add $@
}

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
