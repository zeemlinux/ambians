output "sonarqube_instance_details" {
  value = {
    Name        = aws_instance.Sonarqube.tags["Name"]
    Public_IP   = aws_instance.Sonarqube.public_ip
    Private_IP  = aws_instance.Sonarqube.private_ip
    DNS         = aws_instance.Sonarqube.public_dns
  }
}

output "jenkins_instance_details" {
  value = {
    Name        = aws_instance.Jenkins_Maven_Ansible.tags["Name"]
    Public_IP   = aws_instance.Jenkins_Maven_Ansible.public_ip
    Private_IP  = aws_instance.Jenkins_Maven_Ansible.private_ip
    DNS         = aws_instance.Jenkins_Maven_Ansible.public_dns
  }
}

output "nexus_instance_details" {
  value = {
    Name        = aws_instance.Nexus.tags["Name"]
    Public_IP   = aws_instance.Nexus.public_ip
    Private_IP  = aws_instance.Nexus.private_ip
    DNS         = aws_instance.Nexus.public_dns
  }
}
output "grafana_instance_details" {
  value = {
    Name        = aws_instance.Grafana.tags["Name"]
    Public_IP   = aws_instance.Grafana.public_ip
    Private_IP  = aws_instance.Grafana.private_ip
    DNS         = aws_instance.Grafana.public_dns
  }
}
output "prometheus_instance_details" {
  value = {
    Name        = aws_instance.Prometheus.tags["Name"]
    Public_IP   = aws_instance.Prometheus.public_ip
    Private_IP  = aws_instance.Prometheus.private_ip
    DNS         = aws_instance.Prometheus.public_dns
  }
}
output "splunk_instance_details" {
  value = {
    Name        = aws_instance.Splunk.tags["Name"]
    Public_IP   = aws_instance.Splunk.public_ip
    Private_IP  = aws_instance.Splunk.private_ip
    DNS         = aws_instance.Splunk.public_dns
  }
}



