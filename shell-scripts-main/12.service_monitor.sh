#!/bin/bash

# Variables
SERVICE="nginx"
EMAIL="admin@example.com"

# Check if the service is running
if ! systemctl is-active --quiet $SERVICE; then
    echo "$SERVICE is not running!" | mail -s "$SERVICE Down Alert" $EMAIL
    echo "Alert sent to $EMAIL"
else
    echo "$SERVICE is running."
fi
