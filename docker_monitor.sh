docker_maintenance() {
    log_message "Starting Docker maintenance..."
    
    if ! command -v docker &> /dev/null; then
        log_message "Docker is not installed or not in PATH"
        return
    fi
    
    # Show running containers
    log_message "Running Docker containers:"
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}" | tee -a "$LOG_FILE"
    
    # Check for stopped containers
    STOPPED_CONTAINERS=$(docker ps -a -f status=exited -q | wc -l)
    log_message "Stopped containers: $STOPPED_CONTAINERS"
    
    # Clean up Docker resources
    read -p "Do you want to clean up unused Docker resources? (y/n): " cleanup
    if [[ $cleanup == "y" || $cleanup == "Y" ]]; then
        log_message "Cleaning up Docker resources..."
        docker system prune -f 2>&1 | tee -a "$LOG_FILE"
        log_message "Docker cleanup completed"
    fi
    
    # Show Docker disk usage
    log_message "Docker disk usage:"
    docker system df | tee -a "$LOG_FILE"
    
    log_message "Docker maintenance completed"
}
