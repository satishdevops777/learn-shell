#!/bin/bash

VERSION="1.8.2"
USER="prometheus"
wget https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/node_exporter-${VERSION}.linux-amd64.tar.gz
tar -xzf node_exporter-${VERSION}.linux-amd64.tar.gz
mv node_exporter-${VERSION}.linux-amd64 node_exporter
cd node_exporter
sudo cp node_exporter /usr/local/bin/
sudo chown ${USER}:${USER} /usr/local/bin/node_exporter
cat <<EOL | sudo tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter

[Service]
User=prometheus
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOL

#Start service and enable service
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
