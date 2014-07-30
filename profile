# Carlos Agarie's profile
# A collection of environment variables and settings for my shell.

# Configure this file depending on the OS being used.
case $(uname -s) in
    Darwin)
        # Virtualenvwrapper loading.
        export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python"
        source /usr/local/bin/virtualenvwrapper.sh
        ;;
    Linux)
        ;;
esac

# Change `ll` behavior to use -h flag.
alias ll='ls -Ahlv'

# Solve the problem with rake arguments.
alias rake='noglob rake'

# Corrects problems with Ruby scripts that uses non-ASCII characters.
export LC_ALL="en_US.UTF-8"
