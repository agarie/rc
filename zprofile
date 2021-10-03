# Prepend path so my own scripts go first.
path=('$HOME/rc/bin' '$HOME/.local/bin' '/usr/local/sbin' $path)

export EDITOR=vim
export PAGER=less
export LESS=RSM
export CLICOLOR=1

# Don't print filenames with spaces using quotation marks.
export QUOTING_STYLE=literal

source /usr/share/chruby/chruby.sh
