#!/usr/bin/env zsh

# This script installs the programming languages and libraries I usually use for work.

case $(uname -s) in
  Darwin)
    # Install Homebrew.
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update

    ;;
  Linux)
    # Update local repositories.
    sudo apt-get update


    ;;
esac


# BLAS and LAPACK.

# - install openblas/atlas.


# Ruby.

# - install ruby-install, chruby
# - install ruby 1.9.3, 2.0, 2.1, 2.2
# - for each ruby, install: pry, bundler, smarter_csv, nokogiri, iruby
# - eventually NMatrix, statsample, statsample-{glm,timeseries}, distribution, integration,
#   minimization, plotrb, nyaplot


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
