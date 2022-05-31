
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      owner = var.owner_email
    }
  }
}
