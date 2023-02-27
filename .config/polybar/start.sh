#/usr/bin/env sh

# Terminate already running bar instances
polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

echo '--- start' | tee -a /tmp/polybar.log

polybar batou &

echo "Bar launched at $(date)" | tee -a /tmp/polybar.log
