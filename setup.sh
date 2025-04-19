#!/usr/bin/env zsh

# TODO: Check if the tools I use daily are available.
# zsh, tmux, vim, ruby, git, etc

# Lists of config files for the tools I use, separated by OS.
TOOLS=(.gitconfig .vim .vimrc .zprofile .zshrc .tmux.conf)

# Location for this repository.
RC=$(dirname $0:A)

# Backup existing dotfile, then create a symlink.
function link_dotfile {
  if [[ $(readlink ~/$1) != $RC/$1 ]]; then
    mv ~/$1 ~/$1.backup
    echo ">> Linking $1..."
    ln -s $RC/$1 ~/$1
  fi
}

echo "Updating submodules..."
git submodule update --init --recursive

# Symlinks for all operating systems.
for f in $TOOLS; do
  link_dotfile $f
done

