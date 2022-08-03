module "vpc" {
  source = "../../modules/vpc"

  name           = "sample-vpc"
  cidr_block     = "172.168.0.0/20"
  subnet_newbits = 4
  subnet_count   = 1
}
