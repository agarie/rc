#!/bin/bash

# CPU usage percentage
cpu_usage=$(grep -o 'cpu [0-9.]*' /proc/stat | awk '{sum+=$5} END {printf "%.0f", 100 - sum}')

# Memory usage in GB
mem_total_kb=$(grep '^MemTotal:' /proc/meminfo | awk '{print $2}')
mem_available_kb=$(grep '^MemAvailable:' /proc/meminfo | awk '{print $2}')
mem_used_kb=$((mem_total_kb - mem_available_kb))
mem_total_gb=$(awk "BEGIN {printf \"%.1f\", $mem_total_kb / 1048576}")
mem_used_gb=$(awk "BEGIN {printf \"%.1f\", $mem_used_kb / 1048576}")

# Output JSON for waybar
printf '{"text": "%s%% (%sGB/%sGB)"}' "$cpu_usage" "$mem_used_gb" "$mem_total_gb"
