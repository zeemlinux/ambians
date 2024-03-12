#!/bin/bash
# Tomcat Server Installation
sudo su
#!/bin/bash

# Update your instance
sudo yum update -y

# Install Java (OpenJDK 11)
sudo yum install java-11-amazon-corretto-headless -y

# Verify Java installation
java -version

# Set JAVA_HOME environment variable
echo "export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))" | sudo tee -a /etc/profile
source /etc/profile

# Download Tomcat
TOMCAT_VERSION=9.0.41
wget https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

# Extract Tomcat
sudo tar xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt

# Create a symbolic link to make future upgrades easier
sudo ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat

# Update permissions to allow execution
sudo chmod +x /opt/tomcat/bin/*.sh

# Create a Tomcat systemd service file
cat << EOF | sudo tee /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=root
Group=root

Environment="JAVA_HOME=/usr/lib/jvm/jre"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable and start Tomcat
sudo systemctl enable tomcat
sudo systemctl start tomcat

# Check Tomcat service status
sudo systemctl status tomcat


# Provisioning Ansible Deployer Access
useradd ansibleadmin
echo ansibleadmin | passwd ansibleadmin --stdin
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "ansibleadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers



