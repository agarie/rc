#!/usr/bin/env zsh

DOTFILES=(ackrc gemrc irbrc pryrc vimrc zprofile zshenv zshrc gitconfig gitignore_global Rprofile)

# Make symlinks for all the files in the `rc` repository.
for rc in $DOTFILES; do
  rm ~/.$rc
  ln -s ~/rc/$rc ~/.$rc
done

ln -s ~/rc/vim ~/.vim
