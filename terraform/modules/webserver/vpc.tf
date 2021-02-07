############################################################
# To simplify this test task, no custom VPC will be created.
# Default one will be used istead whenever needed.
############################################################
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}


#################################################################
# To simplify this test task, no custom subnets will be created.
# Default ones will be used istead whenever needed.
#################################################################
resource "aws_default_subnet" "default_az1" {
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "Default subnet for ${var.aws_region}a"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "Default subnet for ${var.aws_region}b"
  }
}

resource "aws_default_subnet" "default_az3" {
  availability_zone = "${var.aws_region}c"

  tags = {
    Name = "Default subnet for ${var.aws_region}c"
  }
}