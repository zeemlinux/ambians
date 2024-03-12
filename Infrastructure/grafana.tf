resource "aws_instance" "grafana" {
  ami                    = "ami-080e1f13689e07408"
  instance_type          = "t2.medium"
  key_name               = "devops"
  security_groups        = [aws_security_group.ambians.name]
  user_data              = file("${path.module}/user_data/grafana.sh") # Assuming you have a user_data script for grafana

  tags = {
    Name = "grafana"
  }
}
