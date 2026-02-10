#!/bin/bash

# List of domains to monitor
DOMAINS=(
    "example.com"
    "google.com"
    "github.com"
    # Add more domains as needed
)

# Function to check SSL certificate expiration date
check_ssl_expiration() {
    DOMAIN=$1
    EXPIRY_DATE=$(echo | openssl s_client -connect "$DOMAIN:443" 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f2)
    EXPIRY_TIMESTAMP=$(date -d "$EXPIRY_DATE" +%s)
    CURRENT_TIMESTAMP=$(date +%s)

    # Calculate days until expiration
    DAYS_LEFT=$(( (EXPIRY_TIMESTAMP - CURRENT_TIMESTAMP) / 86400 ))

    echo "$DOMAIN: Expiry Date: $EXPIRY_DATE, Days Left: $DAYS_LEFT"
    
    # Alert if the certificate is expiring within 30 days
    if [ "$DAYS_LEFT" -lt 30 ]; then
        echo "Alert: $DOMAIN certificate expires soon!"
    fi
}

# Main loop to check each domain
for DOMAIN in "${DOMAINS[@]}"; do
    check_ssl_expiration "$DOMAIN"
done
