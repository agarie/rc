export EDITOR=vim
export PAGER=less
export LESS=RSM

# Solve a minor problem in Scala.
# Source: http://softwareinabottle.wordpress.com/2012/10/21/scala-fixing-the-pesky-java-lang-outofmemoryerror-permgen-space-with-sbt/
export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:PermSize=256M -XX:MaxPermSize=512M"

# Default Markdown engine.
export MARKDOWN_LIB=redcarpet

# NPM binaries.
export PATH="$PATH:/usr/local/share/npm/bin"

# Heroku Toolbelt.
export PATH="$PATH:/usr/local/heroku/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
