# Carlos Agarie's profile
# A collection of environment variables and settings for my shell.

# Configure this file depending on the OS being used.
if [[ $(uname) == "Darwin" ]]; then
  # Do something in OSX.
elif [[ $(uname) == "Linux" ]]; then
  # Do something in Linux.

  # Set Caps Lock key to act as Control.
  /usr/bin/setxkbmap -option 'ctrl:nocaps'

  # Allow pasting with ^v on terminal.
  gconftool --type string --set /apps/gnome-terminal/keybindings/paste '<Ctrl>v'
else
  echo "ERROR: Unrecognized operating system. (in .profile setup)"
fi

export PATH=/usr/local/bin:/usr/local/lib:/usr/sbin:/sbin:$PATH

# Adding npm binaries to PATH.
export PATH="/usr/local/share/npm/bin:$PATH"

# Added by the Heroku Toolbelt.
export PATH="/usr/local/heroku/bin:$PATH"

# Change the default umask.
umask 033

# Remember to turn Ruby warnings on when testing some lib!
export RUBYOPT=""

# Patch to let iTerm use colors.
export CLICOLOR=1
export TERM=xterm-256color

# Default EDITOR for stuff: vim rules!
# export EDITOR=/usr/local/bin/mate

# Change `ll` behavior to use -h flag.
alias ll='ls -lh'

# Solve the problem with rake arguments.
# http://www.scottw.com/zsh-rake-parameters
alias rake='noglob rake'

# Changes the prompt.
# \u : username
# \h : host machine
# \W : directory
# Colors: http://unix.stackexchange.com/a/174/34544
# export PS1="\e[0;31m[\u] \e[33;1m\W/ \e[0;31m$ \e[0m"

# Virtualenvwrapper.
source /usr/local/share/python/virtualenvwrapper.sh

# Geekie project's home directory. Just a shortcut.
export GEEKIE=/Users/carlosagarie/Dropbox/projects/geekie

# Enter the virtualenv & go to project's directory.
alias geekie_init="workon geekie && cd $GEEKIE"
alias trilo_init="workon trilobita && cd $GEEKIE/trilobite"

# Various scripts used to deal with data inside Geekie.
export PATH="$HOME/Projects/geekie-scripts:$PATH"

# Directory to put L4D2 extra stuff.
# export L4D2="~/Library/Application Support/Steam/SteamApps/common/left 4 dead 2/left4dead2/"

# Corrects problems with Ruby scripts that uses non-ASCII characters.
export LC_ALL="en_US.UTF-8"

# Set GCC and G++ environment variables.
# export CC=/usr/local/bin/gcc-4.8
# export CXX=/usr/local/bin/g++-4.8

# Set default Markdown engine.
export MARKDOWN_LIB=redcarpet

# Easier access to some programs.
alias octave='/Applications/Octave.app'

# PostgreSQL.
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop'
alias pgrestart='pg_ctl -D /usr/local/var/postgres restart'

# Connect via SSH to be able to use rmate.
alias ssh-mate='ssh -R 52698:localhost:52698'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
