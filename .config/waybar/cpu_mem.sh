#!/bin/bash

# CPU usage percentage
cpu_usage=$(awk '/^cpu / {total=0; for(i=2;i<=NF;i++) total+=$i; idle=$5; printf "%.0f", 100 * (total - idle) / total}' /proc/stat)

# Memory usage in GB
mem_total_kb=$(grep '^MemTotal:' /proc/meminfo | awk '{print $2}')
mem_available_kb=$(grep '^MemAvailable:' /proc/meminfo | awk '{print $2}')
mem_used_kb=$((mem_total_kb - mem_available_kb))
mem_total_gb=$(awk "BEGIN {printf \"%.1f\", $mem_total_kb / 1048576}")
mem_used_gb=$(awk "BEGIN {printf \"%.1f\", $mem_used_kb / 1048576}")

# Output JSON for waybar
printf '{"text": "%s%% (%sGB/%sGB)"}' "$cpu_usage" "$mem_used_gb" "$mem_total_gb"
