#!/bin/bash

SOURCE="/home/$USER/Documents"
DEST="/home/$USER/backup_$(date +%Y%m%d_%H%M%S)"
LOG="/home/$USER/backup_log.txt"

echo "========== BACKUP STARTED at $(date) ==========" | tee -a "$LOG"

if [ ! -d "$SOURCE" ]; then
    echo "[INFO] Source folder not found. Creating $SOURCE ..." | tee -a "$LOG"
    mkdir -p "$SOURCE"
    echo "This is a test file for backup." > "$SOURCE/sample.txt"
fi

mkdir -p "$DEST"

if cp -r "$SOURCE"/* "$DEST"/ 2>>"$LOG"; then
    echo "[SUCCESS] Backup completed successfully to $DEST" | tee -a "$LOG"
else
    echo "[ERROR] Backup failed!" | tee -a "$LOG"
fi

echo "========== BACKUP FINISHED at $(date) ==========" | tee -a "$LOG"
