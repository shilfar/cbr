
resource "aws_subnet" "public-subnet-A" {
  vpc_id = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public-eu-central-1a"
  }
}

resource "aws_subnet" "public-subnet-B" {
  vpc_id = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public-eu-central-1b"
  }
}
