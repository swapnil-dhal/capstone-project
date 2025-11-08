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