#!/bin/bash
LOG_FILE="/home/$USER/maintenance_log.txt"
ERROR_LOG="/home/$USER/maintenance_error_log.txt"

log_message() {
    echo "[$(date)] $1" | tee -a "$LOG_FILE"
}

error_message() {
    echo "[$(date)] ERROR: $1" | tee -a "$ERROR_LOG"
}

backup() {
    SRC="/home/$USER/Documents"
    DEST="/home/$USER/backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$DEST" || { error_message "Failed to create destination folder."; return; }
    if [ ! -d "$SRC" ]; then
        mkdir -p "$SRC"
        echo "Sample file for backup." > "$SRC/sample.txt"
        log_message "Source folder not found. Created new one."
    fi
    if cp -r "$SRC"/* "$DEST"/ 2>>"$ERROR_LOG"; then
        log_message "Backup successful to $DEST"
    else
        error_message "Backup failed."
    fi
}

update_cleanup() {
    log_message "Starting system update and cleanup..."
    if sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y; then
        log_message "System update and cleanup successful."
    else
        error_message "System update or cleanup failed."
    fi
}

log_monitor() {
    LOG_SRC="/var/log/syslog"
    ALERT_LOG="/home/$USER/log_alerts.txt"
    if [ ! -f "$ALERT_LOG" ]; then
        touch "$ALERT_LOG"
        log_message "Created alert log file: $ALERT_LOG"
    fi
    log_message "Monitoring $LOG_SRC for alerts..."
    tail -Fn0 "$LOG_SRC" | while read line; do
        if echo "$line" | grep -i -E "error|fail|warning" &> /dev/null; then
            echo "[ALERT] $(date): $line" >> "$ALERT_LOG"
            echo "⚠️  Alert detected!"
        fi
    done
}

while true; do
    echo "======================================="
    echo "         FINAL MAINTENANCE SUITE        "
    echo "======================================="
    echo "1. Run Backup"
    echo "2. Update & Clean System"
    echo "3. Monitor Logs"
    echo "4. Exit"
    echo "======================================="
    read -p "Enter your choice: " choice
    case $choice in
        1) backup ;;
        2) update_cleanup ;;
        3) sudo log_monitor ;;
        4) log_message "Exiting Maintenance Suite."; exit 0 ;;
        *) echo "Invalid option. Try again." ;;
    esac
    read -p "Press Enter to return to menu..."
done
