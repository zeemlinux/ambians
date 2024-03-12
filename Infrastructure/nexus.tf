resource "aws_instance" "nexus" {
  ami                    = "ami-0f403e3180720dd7e"
  instance_type          = "t2.medium"
  key_name               = "devops"
  security_groups        = [aws_security_group.ambians.name]
  user_data              = file("${path.module}/user_data/nexus.sh") # Assuming you have a user_data script for nexus

  tags = {
    Name = "nexus"
  }
}
