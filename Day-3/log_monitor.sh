#!/bin/bash
LOG_FILE="/var/log/syslog"
KEYWORDS=("error" "fail" "warning")
ALERT_LOG="/home/$USER/log_alerts.txt"

echo "========== LOG MONITOR STARTED at $(date) ==========" >> "$ALERT_LOG"
echo "Monitoring $LOG_FILE for alerts..."

tail -Fn0 "$LOG_FILE" | while read line; do
    for word in "${KEYWORDS[@]}"; do
        echo "$line" | grep -i "$word" &> /dev/null
        if [ $? = 0 ]; then
            echo "[ALERT] $(date): Detected '$word' → $line" >> "$ALERT_LOG"
            echo "⚠️  Alert: $word detected!"
            break
        fi
    done
done
