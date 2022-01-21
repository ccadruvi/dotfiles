#!/bin/bash

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
