# Carlos Agarie's profile
# A collection of environment variables and settings for my shell.

# Configure this file depending on the OS being used.
case $(uname -s) in
    Darwin)
        # Virtualenvwrapper loading.
        export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python"
        source /usr/local/bin/virtualenvwrapper.sh

        alias ruby_webserver='ruby -rwebrick -e "WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => Dir.pwd).start"'
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

# Change `ll` behavior to use -h flag.
alias ll='ls -Ahlv'

# Solve the problem with rake arguments.
alias rake='noglob rake'

# Corrects problems with Ruby scripts that uses non-ASCII characters.
export LC_ALL="en_US.UTF-8"

### Copied from oh my zsh
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

### Modify theme
