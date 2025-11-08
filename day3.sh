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
