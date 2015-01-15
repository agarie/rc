#!/usr/bin/env zsh

DOTFILES=(ackrc gemrc irbrc pryrc rvmrc vimrc zprofile zshenv zshrc gitconfig gitignore_global Rprofile)

# Make symlinks for all the files in the `rc` repository.
for rc in $DOTFILES; do
  ln -s $HOME/rc/$rc $HOME/.$rc
done

mkdir $HOME/.vim/tmp

case $(uname -s) in
  Darwin)
    ;;
  Linux)
    ;;
esac

# Adicionar os arquivos de configuracao do xmonad, X11 e afins.
