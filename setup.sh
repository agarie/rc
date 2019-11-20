#!/usr/bin/env zsh

# Dotfiles per operating system.
COMMON=(gitconfig vim vimrc zprofile zshrc)
LINUX=(i3status.conf XCompose Xdefaults tmux.conf)
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

# Symlinks for all operating systems.
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

    if [[ $(readlink -f $RC/i3_config) != $(readlink -f ~/.config/i3/config) ]]; then
      echo ">> Linking i3 configuration..."
      mkdir -p ~/.config/i3
      ln -isT $RC/i3_config ~/.config/i3/config
    fi
  ;;
esac

# Install latest version of MRI, enable it and install basic gems.
if (whence chruby > /dev/null) && (whence ruby-install > /dev/null); then
  ruby-install -L # Update Ruby versions list.
  ruby-install ruby 2.3
  chruby 2.3
  gem install bundler pry
fi
