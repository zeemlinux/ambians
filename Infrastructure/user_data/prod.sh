#!/bin/bash
# Tomcat Server Installation
sudo su
hostnamectl set-hostname prod.ambians.project
amazon-linux-extras install tomcat8.5 -y
systemctl enable tomcat
systemctl start tomcat

# Provisioning Ansible Deployer Access
useradd ansibleadmin
echo ansibleadmin | passwd ansibleadmin --stdin
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "ansibleadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

