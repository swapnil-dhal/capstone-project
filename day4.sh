#!/bin/bash

# System Maintenance Suite
# A collection of scripts for automated system maintenance

LOG_FILE="$HOME/maintenance.log"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Script 1: System Backup
backup_system() {
    log_message "Starting system backup..."
    
    BACKUP_DIR="$HOME/backups"
    BACKUP_DATE=$(date +%Y%m%d_%H%M%S)
    
    mkdir -p "$BACKUP_DIR"
    
    # Backup important directories
    DIRS_TO_BACKUP=("$HOME/Documents" "$HOME/Desktop" "$HOME/Downloads")
    
    for dir in "${DIRS_TO_BACKUP[@]}"; do
        if [ -d "$dir" ]; then
            dir_name=$(basename "$dir")
            tar -czf "$BACKUP_DIR/${dir_name}_$BACKUP_DATE.tar.gz" "$dir" 2>/dev/null
            if [ $? -eq 0 ]; then
                log_message "Backed up $dir successfully"
            else
                log_message "ERROR: Failed to backup $dir"
            fi
        fi
    done
    
    # Clean old backups (keep last 5)
    cd "$BACKUP_DIR"
    ls -t *.tar.gz 2>/dev/null | tail -n +6 | xargs rm -f 2>/dev/null
    
    log_message "Backup completed. Location: $BACKUP_DIR"
}

# Script 2: System Update and Cleanup
update_system() {
    log_message "Starting system update and cleanup..."
    
    # Update package list
    log_message "Updating package list..."
    sudo apt update 2>&1 | tee -a "$LOG_FILE"
    
    # Upgrade packages
    log_message "Upgrading packages..."
    sudo apt upgrade -y 2>&1 | tee -a "$LOG_FILE"
    
    # Clean up
    log_message "Cleaning up unnecessary packages..."
    sudo apt autoremove -y 2>&1 | tee -a "$LOG_FILE"
    sudo apt autoclean -y 2>&1 | tee -a "$LOG_FILE"
    
    # Clear temporary files
    log_message "Clearing temporary files..."
    sudo rm -rf /tmp/* 2>/dev/null
    
    log_message "System update and cleanup completed"
}

# Script 3: Log Monitoring
monitor_logs() {
    log_message "Starting log monitoring..."
    
    # Check system logs for errors
    ERROR_COUNT=$(sudo grep -i "error" /var/log/syslog 2>/dev/null | wc -l)
    
    if [ "$ERROR_COUNT" -gt 50 ]; then
        log_message "WARNING: Found $ERROR_COUNT errors in system log!"
        echo "Recent errors:"
        sudo grep -i "error" /var/log/syslog | tail -5
    else
        log_message "System logs look healthy. Error count: $ERROR_COUNT"
    fi
    
    # Check disk space
    DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    
    if [ "$DISK_USAGE" -gt 80 ]; then
        log_message "WARNING: Disk usage is at ${DISK_USAGE}%!"
    else
        log_message "Disk usage is at ${DISK_USAGE}% - OK"
    fi
    
    # Check memory usage
    MEM_USAGE=$(free | awk 'NR==2 {printf "%.0f", $3/$2 * 100}')
    
    if [ "$MEM_USAGE" -gt 90 ]; then
        log_message "WARNING: Memory usage is at ${MEM_USAGE}%!"
    else
        log_message "Memory usage is at ${MEM_USAGE}% - OK"
    fi
    
    log_message "Log monitoring completed"
}

# Script 4: Full Maintenance
full_maintenance() {
    log_message "=== Starting full system maintenance ==="
    backup_system
    echo ""
    update_system
    echo ""
    monitor_logs
    log_message "=== Full maintenance completed ==="
}

# Main Menu
show_menu() {
    clear
    echo "=================================="
    echo "  System Maintenance Suite"
    echo "=================================="
    echo "1. System Backup"
    echo "2. System Update & Cleanup"
    echo "3. Log Monitoring"
    echo "4. Full Maintenance (All tasks)"
    echo "5. View Log File"
    echo "6. Exit"
    echo "=================================="
    echo -n "Select an option [1-6]: "
}

# Main Loop
while true; do
    show_menu
    read choice
    
    case $choice in
        1)
            backup_system
            read -p "Press Enter to continue..."
            ;;
        2)
            update_system
            read -p "Press Enter to continue..."
            ;;
        3)
            monitor_logs
            read -p "Press Enter to continue..."
            ;;
        4)
            full_maintenance
            read -p "Press Enter to continue..."
            ;;
        5)
            if [ -f "$LOG_FILE" ]; then
                less "$LOG_FILE"
            else
                echo "No log file found."
                read -p "Press Enter to continue..."
            fi
            ;;
        6)
            log_message "Exiting maintenance suite"
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            read -p "Press Enter to continue..."
            ;;
    esac
done