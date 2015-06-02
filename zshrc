# Carlos Agarie's zshrc.
#
# Lots of things were copied from github.com/eevee/rc and oh-my-zsh libraries.

# Configuration dependant on the OS being used.
case $(uname -s) in
  Darwin)
    # Homebrew installs binaries in /usr/local/bin.
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

    # Increase available memory for Scala.
    export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:PermSize=256M -XX:MaxPermSize=512M"

    alias ll='ls -AGhlv'

    alias julia='/Applications/Julia-0.3.8.app/Contents/Resources/julia/bin/julia'
    ;;
  Linux)
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

    alias xclip='xclip -selection c'
    alias ll='ls -Ahlv --color=auto'
    ;;
esac

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  export WORKON_HOME=$HOME/.virtualenvs
  source /usr/local/bin/virtualenvwrapper.sh
fi

# Setup chruby and Ruby 2.1.
source /usr/local/share/chruby/chruby.sh
chruby 2.2

# Git aliases.
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

alias gst='git status -sb'
alias ga='git add'
alias gc='git commit'
alias ggpush='git push origin $(current_branch)'
alias gp='git push'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gpall='git push origin $(current_branch) && git push upstream $(current_branch)'

# General aliases.
alias ..='cd ..'
alias ...='cd ../..'

alias ruby_webserver='ruby -rwebrick -e \
  "WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => Dir.pwd).start"'

# Solve the problem with rake arguments.
alias rake='noglob rake'

function tapps() {
    cd ~/Projects/TappsData
    workon datasci
    pwd
}

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

# Corrects problems with Ruby scripts that uses non-ASCII characters.
export LC_ALL="en_US.UTF-8"

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
PROMPT='%B%F{magenta}%c%B%F{green}${vcs_info_msg_0_}%B%F{magenta} %{$reset_color%}λ '
# RPROMPT='%{$fg_bold[yellow]%}[%?]%{$reset_color%}'

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd

# History
setopt extended_history hist_no_store hist_ignore_dups hist_expire_dups_first hist_find_no_dups inc_append_history share_history hist_reduce_blanks hist_ignore_space
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# Some...  options.
setopt autocd beep extendedglob nomatch rcquotes
unsetopt notify

# Don't count common path separators as word characters
WORDCHARS=${WORDCHARS//[&.;\/]}

# Keybindings

# There are some programs that set -o vi depending on the value of $EDITOR.
set -o emacs

bindkey -e

# General movement
# Taken from http://wiki.archlinux.org/index.php/Zsh and Ubuntu's inputrc
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

bindkey "^[[Z" reverse-menu-complete # shift-tab to reverse completions.

autoload -U history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "\e[A" history-beginning-search-backward-end
bindkey "\e[B" history-beginning-search-forward-end
