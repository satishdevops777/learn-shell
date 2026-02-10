#!/bin/bash

# Variables
SOURCE_DIR="/path/to/source"
BACKUP_DIR="/path/to/backup"
TIMESTAMP=$(date +"%Y%m%d%H%M")

# Create backup
tar -czf "$BACKUP_DIR/backup_$TIMESTAMP.tar.gz" "$SOURCE_DIR"

echo "Backup completed: $BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
