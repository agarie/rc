#!/usr/bin/env zsh

# Dotfiles per operating system.
COMMON=(ackrb gemrc irbrc pryrc vimrc zprofile zshenv zshrc gitconfig gitignore_global Rprofile)
LINUX=(i3status.conf Xresources)

# There are some vim bundles added as submodules.
git submodule update --init

# Symlinks for all operating systems.
for f in $COMMON; do
  rm -f ~/.$f
  ln -s $f ~/.$f
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
      rm -f ~/.$f
      ln -s $f ~/.$f
    done

  ;;
esac

# Vim configuration.
rm -f ~/.vim
ln -s ~/rc/vim ~/.vim

# i3wm configuration.
mkdir -p ~/.config/i3
ln -s ~/rc/i3_config ~/.config/i3/config

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
