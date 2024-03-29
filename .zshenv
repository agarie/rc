# Prepend path so my own scripts go first.
path=("$HOME/Code/Personal/rc/bin" $path)

export EDITOR=vim
export PAGER=less
export LESS=RSM
export CLICOLOR=1

# rofi doesn't work without exporting these variables ¯\_(ツ)_/¯
# Source: https://www.reddit.com/r/i3wm/comments/b0xqz5/comment/eip92sb
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Don't print filenames with spaces using quotation marks.
export QUOTING_STYLE=literal
