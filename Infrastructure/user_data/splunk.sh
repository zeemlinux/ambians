#!/bin/bash

# Update system packages
yum update -y

# Splunk installation variables
SPLUNK_USER="splunk"
SPLUNK_GROUP="splunk"
SPLUNK_HOME="/opt/splunk"
SPLUNK_DOWNLOAD_URL="https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.2.2&product=splunk&filename=splunk-8.2.2-a7f645ddaf91-Linux-x86_64.tgz&wget=true"
SPLUNK_TGZ="splunk.tgz"

# Add splunk user and group
groupadd -r ${SPLUNK_GROUP}
useradd -r -m -g ${SPLUNK_GROUP} ${SPLUNK_USER}

# Download Splunk
wget -O ${SPLUNK_TGZ} ${SPLUNK_DOWNLOAD_URL}

# Extract Splunk
tar -xzf ${SPLUNK_TGZ} -C /opt

# Change ownership of the Splunk directory
chown -R ${SPLUNK_USER}:${SPLUNK_GROUP} ${SPLUNK_HOME}

# Cleanup the downloaded tarball
rm -f ${SPLUNK_TGZ}

# Initial startup of Splunk, and accept the license agreement
sudo -u ${SPLUNK_USER} ${SPLUNK_HOME}/bin/splunk start --accept-license --answer-yes --no-prompt

# Enable Splunk to start at boot
sudo -u ${SPLUNK_USER} ${SPLUNK_HOME}/bin/splunk enable boot-start -user ${SPLUNK_USER}

# (Optional) Add Splunk to system path - for ease of use
echo "export PATH=\$PATH:${SPLUNK_HOME}/bin" >> ~/.bash_profile

