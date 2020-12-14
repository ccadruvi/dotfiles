DOTFILES_DIR="$(pwd)"
rm -rf "$HOME/.bash"
cp -r "$DOTFILES_DIR/bash" "$HOME/.bash"
cp -r "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"
cp "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
source "$HOME/.bashrc"

for file in $DOTFILES_DIR/bash/aliases/*; do 
	echo "sourcing: $file"
	source $file; 
done
