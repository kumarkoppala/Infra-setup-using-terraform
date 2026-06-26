resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}/${var.environment}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
  overwrite = true
}

resource "aws_ssm_parameter" "public_subnets_ids" {
  name  = "/${var.project}/${var.environment}/public_subnets_ids"
  type  = "String"
  value = join(",", module.vpc.public_subnets)
  overwrite = true
}

resource "aws_ssm_parameter" "private_subnets_ids" {
  name  = "/${var.project}/${var.environment}/private_subnets_ids"
  type  = "String"
  value = join(",", module.vpc.private_subnets)
  overwrite = true
}

resource "aws_ssm_parameter" "database_subnets_ids" {
  name  = "/${var.project}/${var.environment}/database_subnets_ids"
  type  = "String"
  value = join(",", module.vpc.database_subnets)
  overwrite = true
}