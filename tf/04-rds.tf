module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 3.0"

  publicly_accessible = var.db_publicly_accessible
  identifier          = "fin-db-${var.company_name}"

  engine               = "postgres"
  engine_version       = "14.1"
  instance_class       = var.db_instance_type
  family               = "postgres14" # DB parameter group
  major_engine_version = "14"         # DB option group
  allocated_storage    = 5

  username = var.db_user
  password = var.db_password
  port     = 5432

  skip_final_snapshot    = var.db_skip_final_snapshot
  deletion_protection    = false
  vpc_security_group_ids = [aws_security_group.internet_via_5432_to_rds_postgresql_sg.id]
  subnet_ids = [aws_subnet.public-subnet-A.id, aws_subnet.public-subnet-B.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  #  backup_window      = "03:00-06:00"

  tags = {
    "email" = var.owner_email
    "Name"  = "cbr-rds"
  }

  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]
}
