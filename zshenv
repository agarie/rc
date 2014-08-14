export EDITOR=vim
export PAGER=less
export LESS=RSM

# Default Markdown engine.
export MARKDOWN_LIB=redcarpet

# Haskell binaries. In front of the PATH so `cabal` has priority over the
# package manager-installed one (e.g. haskell-platform from Homebrew).
export PATH="$HOME/.cabal/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
