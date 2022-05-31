
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    "email" = var.owner_email
    "Name"  = "cbr-vpc"
  }
}
