full_maintenance() {
    log_message "=== Starting full system maintenance ==="
    backup_system
    echo ""
    update_system
    echo ""
    monitor_logs
    echo ""
    docker_maintenance
    echo ""
    k8s_monitoring
    log_message "=== Full maintenance completed ==="
}