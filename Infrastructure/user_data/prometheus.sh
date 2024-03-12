#!/bin/bash

# Update the system
apt update && apt upgrade -y

# Install Java 17
apt install -y openjdk-17-jdk

# Verify Java installation
java -version

# Download Prometheus
PROMETHEUS_VERSION="2.33.1"
wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

# Create directories for Prometheus
mkdir -p /etc/prometheus
mkdir -p /var/lib/prometheus

# Extract Prometheus
tar xvf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

# Move binaries
cp prometheus-${PROMETHEUS_VERSION}.linux-amd64/prometheus /usr/local/bin/
cp prometheus-${PROMETHEUS_VERSION}.linux-amd64/promtool /usr/local/bin/

# Move consoles and console_libraries
cp -r prometheus-${PROMETHEUS_VERSION}.linux-amd64/consoles /etc/prometheus
cp -r prometheus-${PROMETHEUS_VERSION}.linux-amd64/console_libraries /etc/prometheus

# Move configuration file and set owner
cp prometheus-${PROMETHEUS_VERSION}.linux-amd64/prometheus.yml /etc/prometheus/
chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
chown prometheus:prometheus /usr/local/bin/prometheus /usr/local/bin/promtool

# Cleanup
rm -rf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz prometheus-${PROMETHEUS_VERSION}.linux-amd64

# Create Prometheus user
useradd --no-create-home --shell /bin/false prometheus

# Change ownership
chown -R prometheus:prometheus /etc/prometheus
chown -R prometheus:prometheus /var/lib/prometheus

# Create systemd service file for Prometheus
cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \\
  --config.file /etc/prometheus/prometheus.yml \\
  --storage.tsdb.path /var/lib/prometheus/ \\
  --web.console.templates=/etc/prometheus/consoles \\
  --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd to recognize the new service, enable and start Prometheus
systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus
