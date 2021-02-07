resource "aws_security_group" "webserver_sg" {
  name        = "${random_pet.random_pet_name.id}-webserver-lb-sg"
  description = "Allow inbound traffic to the Webserver."
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "HTTP traffic to Webserver from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.enable_ssh_access_in_sg
    content {
      description = "SSH traffic to Webserver from anywhere"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      # In this simplified example let it be the access from anywhere ...
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${random_pet.random_pet_name.id}-webserver-lb-sg"
  }
}
