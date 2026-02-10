#!/bin/bash

# Variables
PROMETHEUS_VERSION="2.53.2" 
PROMETHEUS_URL="https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/prometheus"
DATA_DIR="/var/lib/prometheus"
USER="prometheus"
SERVICE_FILE="/etc/systemd/system/prometheus.service"

# Update system and install necessary packages
sudo apt update
sudo apt install -y wget tar

# Download and extract Prometheus
wget ${PROMETHEUS_URL}
tar xvfz prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

# Move binaries and set up configuration
sudo mv prometheus-${PROMETHEUS_VERSION}.linux-amd64/prometheus ${INSTALL_DIR}/
sudo mv prometheus-${PROMETHEUS_VERSION}.linux-amd64/promtool ${INSTALL_DIR}/
sudo mkdir -p ${CONFIG_DIR}
sudo mv prometheus-${PROMETHEUS_VERSION}.linux-amd64/prometheus.yml ${CONFIG_DIR}/

# Create a system user for Prometheus
sudo useradd --no-create-home --shell /bin/false ${USER}

# Set permissions
sudo chown ${USER}:${USER} ${CONFIG_DIR}/prometheus.yml
sudo chown ${USER}:${USER} ${INSTALL_DIR}/prometheus
sudo chown ${USER}:${USER} ${INSTALL_DIR}/promtool

# Create data directory
sudo mkdir -p ${DATA_DIR}
sudo chown ${USER}:${USER} ${DATA_DIR}

# Create systemd service file
cat <<EOL | sudo tee ${SERVICE_FILE}
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=${USER}
Group=${USER}
Restart=always
ExecStart=${INSTALL_DIR}/prometheus \
  --config.file=${CONFIG_DIR}/prometheus.yml \
  --storage.tsdb.path=${DATA_DIR}/data \
  --web.listen-address="0.0.0.0:9090"

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd, start and enable Prometheus
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus

# Check status
sudo systemctl status prometheus

# Clean up
rm -rf prometheus-${PROMETHEUS_VERSION}.linux-amd64*
