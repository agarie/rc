# Carlos Agarie's profile
# A collection of environment variables and settings for my shell.

# Configure this file depending on the OS being used.
if [[ $(uname) == "Darwin" ]]; then
  # Virtualenvwrapper loading.
  export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python"
  source /usr/local/bin/virtualenvwrapper.sh

  alias ruby_webserver='ruby -rwebrick -e "WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => Dir.pwd).start"'

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

# Change the default umask.
umask 033

# vim ftw!
export EDITOR=/usr/bin/vim

# Patch to let iTerm use colors.
export CLICOLOR=1
export TERM=xterm-256color

# Change `ll` behavior to use -h flag.
alias ll='ls -lh'

# Solve the problem with rake arguments.
# http://www.scottw.com/zsh-rake-parameters
alias rake='noglob rake'

# Corrects problems with Ruby scripts that uses non-ASCII characters.
export LC_ALL="en_US.UTF-8"

# Solve a minor problem in Scala.
# Source: http://softwareinabottle.wordpress.com/2012/10/21/scala-fixing-the-pesky-java-lang-outofmemoryerror-permgen-space-with-sbt/
export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:PermSize=256M -XX:MaxPermSize=512M"

# Set default Markdown engine.
export MARKDOWN_LIB=redcarpet

# PostgreSQL.
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop'
alias pgrestart='pg_ctl -D /usr/local/var/postgres restart'

# Adding npm binaries to PATH.
export PATH="/usr/local/share/npm/bin:$PATH"

# Added by the Heroku Toolbelt.
export PATH="/usr/local/heroku/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
