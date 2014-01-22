# Carlos Agarie's profile
# A collection of environment variables and settings for my shell.

# Configure this file depending on the OS being used.
if [[ $(uname) == "Darwin" ]]; then
  # Virtualenvwrapper loading.
  export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python"
  source /usr/local/bin/virtualenvwrapper.sh

  # Used by NMatrix to select the correct version of libstdc++.
  export DYLD_LIBRARY_PATH="/usr/local/Cellar/gcc48/4.8.2/lib/gcc/x86_64-apple-darwin13.0.0/4.8.2"

  alias reboot_virtualbox='sudo /Library/StartupItems/VirtualBox/VirtualBox restart'
elif [[ $(uname) == "Linux" ]]; then
  # Set Caps Lock key to act as Control.
  /usr/bin/setxkbmap -option 'ctrl:nocaps'

  # Allow pasting with ^v on terminal.
  gconftool --type string --set /apps/gnome-terminal/keybindings/paste '<Ctrl>v'

  # Virtualenvwrapper loading.
  source /usr/local/bin/virtualenvwrapper.sh
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

# Patch to let iTerm use colors.
export CLICOLOR=1
export TERM=xterm-256color

# Change `ll` behavior to use -h flag.
alias ll='ls -lh'

# Remember to turn Ruby warnings on when testing some lib!
export RUBYOPT=""

# Solve the problem with rake arguments.
# http://www.scottw.com/zsh-rake-parameters
alias rake='noglob rake'

# Directory to put L4D2 extra stuff.
# export L4D2="~/Library/Application Support/Steam/SteamApps/common/left 4 dead 2/left4dead2/addons"

# Corrects problems with Ruby scripts that uses non-ASCII characters.
export LC_ALL="en_US.UTF-8"

# Set default Markdown engine.
export MARKDOWN_LIB=redcarpet

# PostgreSQL.
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop'
alias pgrestart='pg_ctl -D /usr/local/var/postgres restart'

# Connect via SSH to be able to use rmate.
alias ssh-mate='ssh -R 52698:localhost:52698'

# Needed to allow RVM to work as a function.
source $HOME/.rvm/scripts/rvm
