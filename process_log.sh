#!/bin/sh

# Create logs directory if it doesn't exist
mkdir -p ~/logs

# Timestamp for log file
LOG_FILE=~/logs/process_log_$(date +"%Y%m%d_%H%M%S").log

# Get total memory in KB
TOTAL_MEM=$(grep MemTotal /proc/meminfo | awk '{print $2}')
THRESHOLD=$((TOTAL_MEM / 10))  # 10% of total

# Log all processes
ps -o pid,comm,rss > "$LOG_FILE"

# Append high memory processes
echo "\n===== HIGH MEMORY =====" >> "$LOG_FILE"
ps -o pid,comm,rss | awk -v th="$THRESHOLD" 'NR>1 && $3 > th {print}' >> "$LOG_FILE"

echo "Log saved to $LOG_FILE"

