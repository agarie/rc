#!/usr/bin/env zsh

# Dotfiles per operating system.
COMMON=(ackrc gemrc irbrc pryrc vimrc zshenv zprofile zshrc gitconfig gitignore_global Rprofile tmux.conf)
LINUX=(i3status.conf Xdefaults)

# Clean existing dotfile, then create a symlink and fix permission.
function link_dotfile {
  rm -f ~/.$1
  ln -s $PWD/$1 ~/.$1
}

# There are some vim bundles added as submodules.
git submodule update --init

# Vim configuration.
rm -f ~/.vim
ln -s ~/rc/vim ~/.vim

# Symlinks for all operating systems.
for f in $COMMON; do
  link_dotfile $f
done

case $(uname -s) in
  Darwin)

    # TODO: Check if Homebrew is already installed.
    # Install Homebrew.
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update

  ;;
  # Should change depending on Ubuntu or Arch Linux...
  Linux)
    for f in $LINUX; do
      link_dotfile $f
    done

    # i3wm configuration.
    mkdir -p ~/.config/i3
    ln -s ~/rc/i3_config ~/.config/i3/config

  ;;
esac

#
# Software installation.
#

# Ruby.

# ruby-install is a tool to install various versions of Ruby easily.
sudo ./install/ruby-install.sh

# chruby is a tool to choose which Ruby version to use.
sudo ./install/chruby.sh

# Update Ruby versions list.
ruby-install

# Install latest version of MRI and enable it.
ruby-install ruby 2.3
chruby 2.3

# I expect bundler and pry to be installed for each Ruby.
gem install bundler pry

# Python.

# - install python3, pip3
# - install virtualenv, virtualenvwrapper
# - install numpy, scipy, matplotlib, pandas, ipython[notebook], scikit-learn,
#   csvkit, pep8, jedi
# - create a virtualenv "datasci" with --use-site-packages

# Haskell.

# C/C++.

# - install latest gcc/clang.
# - C:
# - C++: libboost

# Julia.

# - install latest stable version.

# R.

# - install latest stable version.
# - install ggplot2
