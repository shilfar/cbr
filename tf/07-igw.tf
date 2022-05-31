resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "email" = var.owner_email
    "Name"  = "cbr-igw"
  }
}
