# Carlos Agarie's zshrc.

# Set Homebrew ENV variables.
eval "$(/opt/homebrew/bin/brew shellenv)"

# History {{{

# Disables automatically executing commands from the history, instead expand
# commands and reload the line for editing.
setopt HIST_VERIFY

# Save start time and duration of each command in the history file. This option
# is useful for checking how slow some commands are, etc. Free data!
setopt EXTENDED_HISTORY

# Removes the `history` / `fc -l` command from the history after the next
# command is invoked. Useful to keep the history file tidy.
setopt HIST_NO_STORE

# Commands are not inserted into history if they are duplicates of the last one.
setopt HIST_IGNORE_DUPS

# Whenever internal history needs to be saved, oldest duplicates are removed
# before unique commands. Given how large `HISTSIZE` is, this is mostly
# cosmetic.
setopt HIST_EXPIRE_DUPS_FIRST

# Do not show duplicates when searching history independent of their position.
setopt HIST_FIND_NO_DUPS

# New history entries are appended incrementally to the history (after they are
# entered), similar to what the option `INC_APPEND_HISTORY` specifies. This
# option also imports commands from the history file, so the local history will
# have access to the recent history of other, concurrent shells.
setopt SHARE_HISTORY

# Remove extra whitespace from commands before ading them to the history file.
setopt HIST_REDUCE_BLANKS

# Disable saving commands that begin with a space to the history file.
setopt HIST_IGNORE_SPACE

export HISTFILE=~/.zsh_history
export HISTSIZE=1001000
export SAVEHIST=1000000

# }}}

# See the manual page for zshoptions.
setopt combiningchars

# General aliases.
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls --color=auto'

# I still have to use a mac :(
alias ll='ls -Ahlvp'

# Corrects problems with Ruby scripts that uses non-ASCII characters.
export LC_ALL="en_US.UTF-8"

# Ruby aliases.
alias ruby_webserver='ruby -rwebrick -e \
  "WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => Dir.pwd).start"'
alias rake='noglob rake'
alias ri='noglob ri'
alias be='bundle exec'

# Git aliases.
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

alias ga='git add'
alias gb='git branch'
alias gc='git commit --verbose'
alias gco='git checkout'
alias gconf='git diff --check'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gf='git fetch --all'
alias ggforce='git push origin --force-with-lease $(current_branch)'
alias ggpush='git push origin $(current_branch)'
alias gpall='git push origin $(current_branch) && git push upstream $(current_branch)'
alias gst='git status -sb'

# Force a reload of completion system if nothing matched; this fixes installing
# a program and then trying to tab-complete its name
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1    # Because we didn't really complete anything
}

# Always use menu completion, and make the colors pretty!
zstyle ':completion:*' menu select yes
zstyle ':completion:*:default' list-colors ''

# Completers to use: rehash, general completion, then various magic stuff and
# spell-checking.  Only allow two errors when correcting
zstyle ':completion:*' completer _force_rehash _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' max-errors 5

# When looking for matches, first try exact matches, then case-insensiive, then
# partial word completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**'

# Always do mid-word tab completion
setopt complete_in_word
autoload -Uz compinit
compinit

# Prompts. Mostly copied from Oh My ZShell.
autoload -U colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn
theme_precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats ' [%b%c%u%B%F{green}]'
    } else {
        zstyle ':vcs_info:*' formats ' [%b%c%u%B%F{red}●%F{green}]'
    }

    vcs_info
}

setopt prompt_subst

# Default, starting mode.
CURRENT_KEYMAP="INSERT"
PROMPT='[%{$fg_bold[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}] %{$fg_bold[magenta]%}%c%{$fg[green]%}${vcs_info_msg_0_}%{$fg_bold[magenta]%} %{$reset_color%}λ '
RPROMPT='%{$fg_bold[yellow]%}[%?]%{$reset_color%} ($CURRENT_KEYMAP)'

# The widget `zle-keymap-select` is invoked after each keymap change. This
# function updates CURRENT_KEYMAP so it can be visualized in the PROMPT.
# Inspired by: https://koenwoortman.com/zsh-vim-mode/
zle-keymap-select() {
  # NOTE: Why only these 2 keymaps show up? What about viopp, visual, etc?
  if [ "${KEYMAP}" = 'vicmd' ]; then
    CURRENT_KEYMAP="COMMAND"
  else
    CURRENT_KEYMAP="INSERT"
  fi
  zle reset-prompt
}
zle -N zle-keymap-select

# Reset to default mode at the end of line input reading.
zle-line-finish() {
  CURRENT_KEYMAP="INSERT"
}
zle -N zle-line-finish

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd

# Some...  options.
setopt autocd beep extendedglob nomatch rcquotes
unsetopt notify

# Don't count common path separators as word characters
WORDCHARS=${WORDCHARS//[&.;\/]}

# chruby initialization and setup. {{{

export CHRUBY_DIR="/opt/homebrew/opt/chruby"
source $CHRUBY_DIR/share/chruby/chruby.sh
source $CHRUBY_DIR/share/chruby/auto.sh

# }}}

# Keybindings {{{

# Vim bindings.
bindkey -v

# How long zsh waits for bound multi-character sequences in 1/100s of a second,
# so this is 10ms. The default value is far too long for my taste.
export KEYTIMEOUT=1

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line

bindkey "^[[Z" reverse-menu-complete # shift-tab to reverse completions.

# Bind up and down arrows to history search.
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

# Mac OS X.
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Ctrl+f starts a fzf prompt inside my project directories in order to create a
# tmux session and attach to it.
bindkey -s "^f" "tmux-session-from-dir\n"

# Edit the current command line in $EDITOR.
autoload edit-command-line
zle -N edit-command-line
bindkey -M viins '^x^e' edit-command-line

# }}}

# Machine-specific configuration.
source ~/.zlocal

# vim: foldmethod=marker foldlevel=0
