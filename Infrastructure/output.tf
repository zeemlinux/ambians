output "sonarqube_instance_details" {
  value = {
    Name        = aws_instance.sonarqube.tags["Name"]
    Public_IP   = aws_instance.sonarqube.public_ip
    Private_IP  = aws_instance.sonarqube.private_ip
    DNS         = aws_instance.sonarqube.public_dns
  }
}

output "jenkins_instance_details" {
  value = {
    Name        = aws_instance.jenkins.tags["Name"]
    Public_IP   = aws_instance.jenkins.public_ip
    Private_IP  = aws_instance.jenkins.private_ip
    DNS         = aws_instance.jenkins.public_dns
  }
}

output "nexus_instance_details" {
  value = {
    Name        = aws_instance.nexus.tags["Name"]
    Public_IP   = aws_instance.nexus.public_ip
    Private_IP  = aws_instance.nexus.private_ip
    DNS         = aws_instance.nexus.public_dns
  }
}
output "grafana_instance_details" {
  value = {
    Name        = aws_instance.grafana.tags["Name"]
    Public_IP   = aws_instance.grafana.public_ip
    Private_IP  = aws_instance.grafana.private_ip
    DNS         = aws_instance.grafana.public_dns
  }
}
output "prometheus_instance_details" {
  value = {
    Name        = aws_instance.prometheus.tags["Name"]
    Public_IP   = aws_instance.prometheus.public_ip
    Private_IP  = aws_instance.prometheus.private_ip
    DNS         = aws_instance.prometheus.public_dns
  }
}
output "splunk_instance_details" {
  value = {
    Name        = aws_instance.splunk.tags["Name"]
    Public_IP   = aws_instance.splunk.public_ip
    Private_IP  = aws_instance.splunk.private_ip
    DNS         = aws_instance.splunk.public_dns
  }
}



