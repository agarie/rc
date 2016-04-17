#!/usr/bin/env zsh

git submodule update --init

# Make symlinks for all the files in the `rc` repository.
for f in ackrc gemrc i3status.conf irbrc pryrc vimrc zprofile zshenv zshrc gitconfig gitignore_global Rprofile Xresources; do
  rm -f ~/.$f
  ln -s ~/rc/$f ~/.$f
done

# Vim configuration.
rm -f ~/.vim
ln -s ~/rc/vim ~/.vim

# i3wm configuration.
mkdir -p ~/.config/i3
ln -s ~/rc/i3_config ~/.config/i3/config
