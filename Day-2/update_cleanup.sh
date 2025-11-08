#!/bin/bash
LOG="/home/$USER/update_cleanup_log.txt"
echo "========== SYSTEM UPDATE STARTED at $(date) ==========" | tee -a "$LOG"
if sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y; then
    echo "[SUCCESS] System updated and cleaned successfully." | tee -a "$LOG"
else
    echo "[ERROR] System update or cleanup failed." | tee -a "$LOG"
fi
echo "========== SYSTEM UPDATE FINISHED at $(date) ==========" | tee -a "$LOG"
