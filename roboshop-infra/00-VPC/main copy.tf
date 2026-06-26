module "vpc" {
  source         = "git::https://github.com/kumarkoppala/Infra-setup-using-terraform.git//VPC-Modules?ref=main"
  public_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_cidrs  = ["10.0.11.0/24", "10.0.12.0/24"]
  database_cidrs = ["10.0.21.0/24", "10.0.22.0/24"]
  project        = "roboshop"
  env            = var.env

}