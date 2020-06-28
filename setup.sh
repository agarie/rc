#!/usr/bin/env zsh

# Dotfiles per operating system.
COMMON=(gitconfig vim vimrc zprofile zshrc)
LINUX=(XCompose Xdefaults tmux.conf)
RC=$(dirname $0:A)

# Backup existing dotfile, then create a symlink.
function link_dotfile {
  if [[ $(readlink -f ~/.$1) != $(readlink -f $RC/$1) ]]; then
    echo ">> Linking $1..."
    ln -isT $RC/$1 ~/.$1
  fi
}

# TODO: Check if the tools I use daily are available.
# vim, zsh, tmux, ruby, git

# There are some vim bundles added as submodules.
echo "Updating submodules..."
git submodule update --init --recursive

# Create symlinks.
for f in $COMMON; do
  link_dotfile $f
done

case $(uname -s) in
  Darwin)
  ;;

  # TODO: Should change depending on Ubuntu or Arch Linux...
  Linux)
    for f in $LINUX; do
      link_dotfile $f
    done
  ;;
esac

# Install latest version of MRI, enable it and install basic gems.
if (whence chruby > /dev/null) && (whence ruby-install > /dev/null); then
  ruby-install -L # Update Ruby versions list.
  ruby-install ruby 2.3
  chruby 2.3
  gem install bundler pry
fi
