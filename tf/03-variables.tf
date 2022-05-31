variable "region" {
  description = "Region to launch infra in"
  type        = string
  default     = "eu-central-1"
}

variable "company_name" {
  description = "Company name"
  type        = string
  default     = "clouddevops"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_subnets" {
  description = "List of public subnets"
  type        = list(string)
  default = [
    "10.0.1.0/24",
  "10.0.2.0/24"]
}

variable "vpc_private_subnets" {
  description = "List of private subnets"
  type        = list(string)
  default = [
    "10.0.10.0/24",
  "10.0.20.0/24"]
}

variable "owner_email" {
  description = "Owner email"
  type        = string
  default     = "Ildar_Sharafeev@epam.com"
}
variable "ssh_inbound_list_allowed" {
  description = "List of CIRDs allowed to connect via SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "azs" {
  description = "List of AZs you need in this region"
  type        = list(string)
  default = [
    "eu-central-1a",
  "eu-central-1b"]
}

variable "db_name" {
  description = "Enter db name"
  type        = string
  default     = "mytestdb"
}

variable "db_user" {
  description = "Enter db admin name"
  type        = string
  default     = "postgres"
  sensitive   = true
}

variable "db_password" {
  description = "Enter db admin password"
  type        = string
  default     = "ubuntu"
  sensitive   = true
}

variable "db_publicly_accessible" {
  description = "Need public access to RDS?"
  type        = bool
  default     = true
}

variable "db_skip_final_snapshot" {
  description = "Skip final snapshot before destroy of RDS?"
  type        = bool
  default     = true
}

variable "db_instance_type" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "cluster_name" {
  description = "K8s cluster name"
  type        = string
  default     = "cbr-valute"
}
