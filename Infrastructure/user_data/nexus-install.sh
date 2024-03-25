#!/bin/bash

# Update the system
apt-get update && apt-get upgrade -y

# Install Java (Nexus requires Java to run)
apt-get install -y openjdk-17-jdk

# Verify Java installation
java -version

# Download Nexus
NEXUS_VERSION="3.38.1-01"
wget https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz

# Extract Nexus
mkdir /opt/nexus
tar xzvf nexus-${NEXUS_VERSION}-unix.tar.gz -C /opt/nexus --strip-components=1

# Add nexus user
useradd -r -d /opt/nexus -s /bin/false nexus

# Change ownership of the Nexus directory
chown -R nexus:nexus /opt/nexus

# Create a systemd service file for Nexus
echo "[Unit]
Description=Nexus Repository Manager
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
Restart=on-abort

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/nexus.service

# Enable and start Nexus service
systemctl daemon-reload
systemctl enable nexus.service
systemctl start nexus.service
