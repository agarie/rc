# Carlos Agarie's profile
# A collection of environment variables and settings for my shell.

# Configure this file depending on the OS being used.
case $(uname -s) in
    Darwin)
        # Virtualenvwrapper.
        export WORKON_HOME="$HOME/.virtualenvs"
        export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python"
        source /usr/local/bin/virtualenvwrapper.sh
        ;;
    Linux)
        # Set Caps Lock key to act as Control.
        # /usr/bin/setxkbmap -option 'ctrl:nocaps'

        # Allow pasting with ^v on terminal.
        # gconftool --type string --set /apps/gnome-terminal/keybindings/paste '<Ctrl>v'

        # Virtualenvwrapper loading.
        # source /usr/local/bin/virtualenvwrapper.sh
        ;;
esac

### Aliases.

alias ll='ls -Ahlv'

alias ruby_webserver='ruby -rwebrick -e \
  "WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => Dir.pwd).start"'

# Solve the problem with rake arguments.
alias rake='noglob rake'

# Corrects problems with Ruby scripts that uses non-ASCII characters.
export LC_ALL="en_US.UTF-8"

### Prompts.
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
RPROMPT='%{$fg_bold[yellow]%}[%?]%{$reset_color%}'

### Git aliases
alias gst='git status -sb'

### Keybindings

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

# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line

# Tab completion
bindkey '^i' complete-word # tab to do menu
bindkey "\e[Z" reverse-menu-complete # shift-tab to reverse menu

# Up/down arrow.
# I want shared history for ^R, but I don't want another shell's activity to
# mess with up/down. This does that.
down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N down-line-or-local-history
up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
zle -N up-line-or-local-history

bindkey "\e[A" up-line-or-local-history
bindkey "\eOA" up-line-or-local-history
bindkey "\e[B" down-line-or-local-history
bindkey "\eOB" down-line-or-local-history
