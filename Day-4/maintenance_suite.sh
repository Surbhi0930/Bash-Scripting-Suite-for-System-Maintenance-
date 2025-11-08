#!/bin/bash
while true; do
    echo "======================================="
    echo "        SYSTEM MAINTENANCE SUITE        "
    echo "======================================="
    echo "1. Run Backup"
    echo "2. Update & Clean System"
    echo "3. Monitor Logs"
    echo "4. Exit"
    echo "======================================="
    read -p "Enter your choice: " choice
    case $choice in
        1)
            if [ -f ./backup.sh ]; then
                ./backup.sh
            else
                echo "backup.sh not found!"
            fi
            read -p "Press Enter to continue..."
            ;;
        2)
            if [ -f ./update_cleanup.sh ]; then
                ./update_cleanup.sh
            else
                echo "update_cleanup.sh not found!"
            fi
            read -p "Press Enter to continue..."
            ;;
        3)
            if [ -f ./log_monitor.sh ]; then
                sudo ./log_monitor.sh
            else
                echo "log_monitor.sh not found!"
            fi
            read -p "Press Enter to continue..."
            ;;
        4)
            echo "Exiting Maintenance Suite. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Try again."
            sleep 2
            ;;
    esac
done
