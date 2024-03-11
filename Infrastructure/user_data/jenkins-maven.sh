#!/bin/bash
sudo su
yum update –y
hostnamectl set-hostname jenkins.ambians.project
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
amazon-linux-extras install epel -y
amazon-linux-extras install java-openjdk11 -y
yum install jenkins -y
echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
systemctl enable jenkins
systemctl start jenkins

# Installing Git
yum install git -y
# Install tools wget unzip 
yum install wget unzip -y

# Installing Ansible
amazon-linux-extras install ansible2 -y
yum install python-pip -y
pip install boto3

# Provisioning Ansible Deployer Access
useradd ansibleadmin
echo ansibleadmin | passwd ansibleadmin --stdin
sed -i "s/.*#host_key_checking = False/host_key_checking = False/g" /etc/ansible/ansible.cfg
sed -i "s/.*#enable_plugins = host_list, virtualbox, yaml, constructed/enable_plugins = aws_ec2/g" /etc/ansible/ansible.cfg
ansible-galaxy collection install amazon.aws

# Enable Password Authentication and Grant Sudo Privilege
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "ansibleadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Apache Maven Installation/Config
# sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
# sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
# sudo yum install -y apache-maven
# sudo yum install java-1.8.0-devel

# sudo /usr/sbin/alternatives --config java
# sudo /usr/sbin/alternatives --config javac

#  Use The Amazon Linux 2 AMI When Launching The Jenkins VM/EC2 Instance
#  Instance Type: t2.medium or small minimum
# Open Port (Security Group): 8080 
# Install and configure Maven
#!/bin/bash

# MAVEN 
# Variables
MAVEN_VERSION=3.8.4
MAVEN_BASE_URL="https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries"

# Install wget and unzip if they are not installed
sudo yum install -y wget unzip  #|| sudo apt-get install -y wget unzip

# Download Maven
wget ${MAVEN_BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.zip -P /tmp

# Extract Maven
sudo unzip /tmp/apache-maven-${MAVEN_VERSION}-bin.zip -d /opt/maven

# Set up Maven environment variables
echo "export M2_HOME=/opt/maven/apache-maven-${MAVEN_VERSION}" | sudo tee -a /etc/profile.d/maven.sh
echo "export MAVEN_HOME=/opt/maven/apache-maven-${MAVEN_VERSION}" | sudo tee -a /etc/profile.d/maven.sh
echo "export PATH=\${M2_HOME}/bin:\${PATH}" | sudo tee -a /etc/profile.d/maven.sh

# Load Maven environment variables
source /etc/profile.d/maven.sh

# Verify Installation
mvn -version
# https://devopscube.com/install-maven-guide/