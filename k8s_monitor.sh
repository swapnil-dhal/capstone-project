k8s_monitoring() {
    log_message "Starting Kubernetes monitoring..."
    
    if ! command -v kubectl &> /dev/null; then
        log_message "kubectl is not installed or not in PATH"
        return
    fi
    
    # Check cluster status
    log_message "Checking Kubernetes cluster status..."
    kubectl cluster-info 2>&1 | tee -a "$LOG_FILE"
    
    # Show all pods status
    log_message "Pod status across all namespaces:"
    kubectl get pods --all-namespaces | tee -a "$LOG_FILE"
    
    # Check for failed pods
    FAILED_PODS=$(kubectl get pods --all-namespaces --field-selector=status.phase=Failed --no-headers 2>/dev/null | wc -l)
    if [ "$FAILED_PODS" -gt 0 ]; then
        log_message "WARNING: Found $FAILED_PODS failed pods!"
        kubectl get pods --all-namespaces --field-selector=status.phase=Failed
    else
        log_message "All pods are healthy"
    fi
    
    # Show node status
    log_message "Node status:"
    kubectl get nodes | tee -a "$LOG_FILE"
    
    # Show resource usage
    log_message "Top resource-consuming pods:"
    kubectl top pods --all-namespaces 2>/dev/null | head -10 | tee -a "$LOG_FILE"
    
    log_message "Kubernetes monitoring completed"
}
