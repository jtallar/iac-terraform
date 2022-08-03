provider "aws" {
  region = var.region
  default_tags {
    tags = {
      DeployedBy = "Terraform"
      Region     = var.region
    }
  }
}
