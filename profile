# Carlos Agarie's profile
# A collection of environment variables and settings for my shell.

# Configure this file depending on the OS being used.
case $(uname -s) in
    Darwin)
        # Patch to let iTerm use colors.
        export CLICOLOR=1
        export TERM=xterm-256color

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
