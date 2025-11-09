# System Maintenance Suite | Capstone Project

A comprehensive Bash scripting suite for automated system maintenance tasks, including Docker and Kubernetes monitoring capabilities.

## 🎯 Overview

This maintenance suite automates common system administration tasks for Linux servers running Docker and Kubernetes. It provides an interactive menu-driven interface for system backup, updates, monitoring, and container management.

## ✨ Features

### Core System Maintenance

**System Backup**
- Backs up Documents, Desktop, and Downloads folders with timestamp
- Creates compressed tar.gz archives
- All backups stored in `~/backups` directory

**System Update & Cleanup**
- Updates apt package lists
- Upgrades installed packages
- Removes unnecessary packages and dependencies
- Cleans up temporary files in `/tmp`
- Comprehensive logging of all update operations

**Log Monitoring**
- Monitors system logs for errors
- Tracks disk space usage with alerts (warns if >80% used)
- Monitors memory usage with alerts (warns if >90% used)
- Displays recent error counts from system logs
- Real-time resource monitoring

### Container & Orchestration

**Docker Maintenance**
- Lists all running Docker containers with status
- Shows stopped containers count
- Interactive cleanup of unused Docker resources (images, containers, volumes)
- Displays Docker disk usage statistics
- Helps optimize Docker storage space

**Kubernetes Monitoring**
- Checks cluster health and connectivity status
- Displays pod status across all namespaces
- Detects and alerts on failed pods
- Shows node status and health
- Displays top resource-consuming pods
- Real-time cluster monitoring

**Service Dashboard**
- Quick overview of system resources (CPU load, memory, disk usage)
- Real-time Docker container status display
- Kubernetes pod status at a glance
- Consolidated view of all services in one screen

### Additional Features

**Comprehensive Logging**
- All operations logged with timestamps to `~/maintenance.log`
- Success/failure status for each operation
- Warning alerts for critical issues
- Searchable log history

**Interactive Menu System**
- User-friendly numbered menu interface
- Run individual tasks or full maintenance suite
- View logs directly from the menu
- Confirmation prompts for destructive operations

**Full Maintenance Mode**
- Runs all maintenance tasks in sequence
- Complete system health check
- Ideal for scheduled maintenance windows
- Comprehensive system overview in one run

**Error Handling**
- Built-in error checking for all operations
- Graceful handling of missing dependencies
- Clear error messages and warnings
- Continues operation even if individual tasks fail