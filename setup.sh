#!/usr/bin/env zsh

# TODO: Check if the tools I use daily are available.
# zsh, tmux, vim, ruby, git, etc

# Lists of config files for the tools I use, separated by OS.
COMMON=(gitconfig vim vimrc zprofile zshrc tmux.conf)
LINUX=(XCompose Xdefaults)

# Location for this repository.
RC=$(dirname $0:A)

# Backup existing dotfile, then create a symlink.
function link_dotfile {
  if [[ $(readlink -f ~/.$1) != $(readlink -f $RC/$1) ]]; then
    mv ~/.$1 ~/.$1.backup
    echo ">> Linking $1..."
    ln -isT $RC/$1 ~/.$1
  fi
}

echo "Updating submodules..."
git submodule update --init --recursive

# Create symlinks.
for f in $COMMON; do
  link_dotfile $f
done

# Create symlinks for tools only used on Linux.
if [[ $(uname -s) == "Linux" ]]; then
  for f in $LINUX; do
    link_dotfile $f
  done
fi

# Install latest version of MRI, enable it and install basic gems.
if (whence chruby > /dev/null) && (whence ruby-install > /dev/null); then
  ruby-install -L # Update Ruby versions list.
  ruby-install ruby 2.3
  chruby 2.3
  gem install bundler pry
fi
