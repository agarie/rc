export EDITOR=vim
export PAGER=less
export LESS=RSM

# Solve a minor problem in Scala.
# Source: http://softwareinabottle.wordpress.com/2012/10/21/scala-fixing-the-pesky-java-lang-outofmemoryerror-permgen-space-with-sbt/
export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:PermSize=256M -XX:MaxPermSize=512M"

# Default Markdown engine.
export MARKDOWN_LIB=redcarpet

export PATH=/usr/local/bin:/usr/local/lib:/usr/sbin:/sbin:$PATH

# Adding npm binaries to PATH.
export PATH="/usr/local/share/npm/bin:$PATH"

# Added by the Heroku Toolbelt.
export PATH="/usr/local/heroku/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
