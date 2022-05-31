resource "aws_security_group" "internet_via_5432_to_rds_postgresql_sg" {
  name        = "internet_via_5432_to_rds_postgresql_sg"
  description = "Allow 5432_port inbound"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "Allow 5432_port inbound"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.ssh_inbound_list_allowed
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
}
