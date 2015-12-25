#!/usr/bin/env zsh

git submodule update --init

# Make symlinks for all the files in the `rc` repository.
for rc in ackrc gemrc irbrc pryrc vimrc zprofile zshenv zshrc gitconfig gitignore_global Rprofile; do
  rm -f ~/.$rc
  ln -s ~/rc/$rc ~/.$rc
done

# Vim configuration.
rm -f ~/.vim
ln -s ~/rc/vim ~/.vim

# i3wm configuration.
mkdir -p ~/.config/i3
ln -s ~/rc/i3_config ~/.config/i3/config
