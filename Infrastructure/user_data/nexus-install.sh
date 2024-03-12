#!/bin/bash

# Update your instance's package repository
yum update -y

# Install Corretto 17
wget https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.rpm
yum install -y amazon-corretto-17-x64-linux-jdk.rpm

# Verify Java installation
java -version

# Download Nexus
wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz

# Extract Nexus
mkdir /opt/nexus
tar -zxvf latest-unix.tar.gz -C /opt/nexus --strip-components=1

# Add nexus user
useradd nexus
chown -R nexus:nexus /opt/nexus

# Run Nexus as a service
echo "[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/nexus.service

# Enable and start Nexus service
systemctl enable nexus.service
systemctl start nexus.service
