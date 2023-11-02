# module "vpc" {
#   source         = "./modules/vpc"
#   cidr_block     = "10.0.0.0/16"
#   ami            = "ami-078c1149d8ad719a7"
#   instance_type  = "t2.micro"
#   private_cidr_1 = "10.0.1.0/24"
#   public_cidr_1 = "10.0.101.0/24"

# }

locals {
  cidr_block     = "10.0.0.0/16"
  ami            = "ami-078c1149d8ad719a7"
  instance_type  = "t2.micro"
  azs            = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
  private_cidr = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
  public_cidr  = ["10.0.101.0/24","10.0.102.0/24","10.0.103.0/24"]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "prem-vpc"
  cidr = local.cidr_block
  azs = local.azs
  private_subnets = local.private_cidr
  public_subnets = local.public_cidr

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

}
