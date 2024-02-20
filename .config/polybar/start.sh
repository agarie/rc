#/usr/bin/env sh

# Terminate already running bar instances
polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

echo '--- start' | tee -a /tmp/polybar.log

# Taken from: https://github.com/polybar/polybar/issues/763
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload batou &
  done
else
  polybar --reload batou &
fi
polybar batou &

echo "Bar launched at $(date)" | tee -a /tmp/polybar.log
