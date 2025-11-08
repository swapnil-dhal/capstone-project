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