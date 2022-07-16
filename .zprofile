# hello mac
if [[ $(uname -s) == "Linux" ]]; then
  export CHRUBY_DIR="/usr"
else
  export CHRUBY_DIR="/usr/local/opt/chruby"
fi

source $CHRUBY_DIR/share/chruby/chruby.sh
chruby 3
source $CHRUBY_DIR/share/chruby/auto.sh

