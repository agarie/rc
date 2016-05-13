#!/usr/bin/env zsh

# Dotfiles per operating system.
COMMON=(ackrc gitconfig gitignore_global irbrc pryrc vim vimrc zprofile zshenv zshrc)
LINUX=(i3status.conf Xdefaults tmux.conf)
RC=$(dirname $0)

# Backup existing dotfile, then create a symlink.
function link_dotfile {
  if [[ $(readlink -f ~/.$1) != $(readlink -f $RC/$1) ]]; then
    echo "Linking $1..."
    ln -isT $RC/$1 ~/.$1
  fi
}

# There are some vim bundles added as submodules.
echo "Updating submodules..."
git submodule update --init --recursive

# Symlinks for all operating systems.
for f in $COMMON; do
  link_dotfile $f
done

case $(uname -s) in
  Darwin)
    echo "Mac OS X detected."

    # Install Homebrew.
    if whence brew > /dev/null; then
      "Installing Homebrew..."
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
      "Homebrew detected. Updating packages..."
      brew update
    fi

    brew install ruby-install chruby haskell-platform python python3
    cabal update
    pip install virtualenv virtualenvwrapper
  ;;
  # Should change depending on Ubuntu or Arch Linux...
  Linux)
    for f in $LINUX; do
      link_dotfile $f
    done

    # i3wm configuration.
    mkdir -p ~/.config/i3
    ln -s $RC/i3_config ~/.config/i3/config

    if whence ruby-install > /dev/null; then
      echo "Installing ruby-install..."
      sudo ./install/ruby-install.sh > /dev/null 2>&1
    fi

    if whence chruby > /dev/null; then
      echo "Installing chruby..."
      sudo ./install/chruby.sh > /dev/null 2>&1
    fi

    # Install GHC, Cabal, etc.
    # Install Python and Python3.
  ;;
esac

# Install latest version of MRI, enable it and install basic gems.
ruby-install -L # Update Ruby versions list.
ruby-install ruby 2.3
chruby 2.3
gem install bundler pry

# C/C++.
# - install latest gcc/clang.
