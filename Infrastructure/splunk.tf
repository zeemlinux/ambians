resource "aws_instance" "splunk" {
  ami                    = "ami-0f403e3180720dd7e"
  instance_type          = "t2.large"
  key_name               = "devops"
  security_groups        = [aws_security_group.ambians.name]
#  user_data              = file("${path.module}/user_data/splunk.sh") # Assuming you have a user_data script for splunk

  tags = {
    Name = "splunk.ambians.project"
  }
}
