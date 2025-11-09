service_dashboard() {
    clear
    echo "=================================="
    echo "  Service Status Dashboard"
    echo "=================================="
    echo ""
    
    # System Info
    echo "--- System Resources ---"
    echo "CPU Load: $(uptime | awk -F'load average:' '{print $2}')"
    echo "Memory: $(free -h | awk 'NR==2 {print $3 "/" $2}')"
    echo "Disk: $(df -h / | awk 'NR==2 {print $5 " used"}')"
    echo ""
    
    # Docker
    if command -v docker &> /dev/null; then
        echo "--- Docker Containers ---"
        docker ps --format "{{.Names}}: {{.Status}}" 2>/dev/null || echo "No containers running"
        echo ""
    fi
    
    # Kubernetes
    if command -v kubectl &> /dev/null; then
        echo "--- Kubernetes Pods ---"
        kubectl get pods --all-namespaces --no-headers 2>/dev/null | awk '{print $2 ": " $4}' | head -5 || echo "Cluster not accessible"
        echo ""
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}