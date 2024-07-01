#!/bin/bash

DOTFILES_DIR=$(dirname "$0")
rm -rf "$HOME/.bash"
cp -r "$DOTFILES_DIR/bash" "$HOME/.bash"
cp -r "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"
cp "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
cp "$DOTFILES_DIR/khotkeysrc" "$HOME/.config/khotkeysrc"
source "$HOME/.bashrc"

