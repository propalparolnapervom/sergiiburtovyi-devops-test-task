resource "random_pet" "random_pet_name" {
  keepers = {
    ami_id = "websrv-${var.aws_region}"
  }

  length    = 3
  separator = "-"
  prefix    = "websrv"
}

