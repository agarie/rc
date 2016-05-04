#!/usr/bin/env zsh

# Dotfiles per operating system.
COMMON=(ackrb gemrc irbrc pryrc vimrc zprofile zshenv zshrc gitconfig gitignore_global Rprofile tmux.conf)
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

# BLAS and LAPACK.
# - install openblas/atlas.

# Ruby.
# - install ruby-install, chruby
# - install latest ruby
# - for each ruby, install: pry, bundler, smarter_csv, nokogiri, iruby
# - eventually NMatrix, statsample, statsample-{glm,timeseries}, distribution, integration,
#   minimization, plotrb, nyaplot

sudo ./install/ruby-install.sh
sudo ./install/chruby.sh

# Python.

# - install python3, pip3
# - install virtualenv, virtualenvwrapper
# - install numpy, scipy, matplotlib, pandas, ipython[notebook], scikit-learn,
#   csvkit, pep8, jedi
# - create a virtualenv "datasci" with --use-site-packages

# C/C++.

# - install gcc-4.9/g++-4.9
# - C:
# - C++: libboost (latest stable)

# Julia.

# - install latest stable version.

# R.

# - install latest stable version.
# - install ggplot2
