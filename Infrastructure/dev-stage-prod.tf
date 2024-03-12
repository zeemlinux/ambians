locals {
  instances = {
    "dev" = {
      name = "dev-env"
    },
    "stage" = {
      name = "stage-env"
    },
    "prod" = {
      name = "prod-env"
    }
  }
}
resource "aws_instance" "ambians_env" {
  for_each = local.instances

  ami             = "ami-0f403e3180720dd7e" # Replace with the Amazon Linux 2 AMI ID for your region
  instance_type   = "t2.micro"
  key_name        = "devops" # Assumes you have this key pair created in AWS
  security_groups = [aws_security_group.ambians.name]

  tags = {
    Name = each.value.name
  }

  # Example user data script, replace with your actual scripts
  user_data = file("${path.module}/user_data/${each.key}.sh")
}
output "instance_details" {
  value = { for key, instance in aws_instance.ambians_env : key => {
    Public_IP  = instance.public_ip
    Private_IP = instance.private_ip
    DNS        = instance.public_dns
  } }
}
