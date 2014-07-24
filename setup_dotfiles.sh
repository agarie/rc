#!/bin/zsh

DOTFILES=(ackrc gemrc irbrc pryrc rvmrc vim vimrc zshenv zshrc gitconfig gitignore_global Rprofile)

# Make symlinks for all the files in the `rc` repository.
for rc in $DOTFILES; do
  ln -s $HOME/rc/$rc $HOME/.$rc
done
