provider "aws" {
  region = var.region
}

module "ec2_instance" {
  source             = "./module"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = var.subnet_id
  vpc_id             = var.vpc_id
  security_groups    = var.security_groups
  ingress_rules = var.ingress_rules
  egress_rules = var.egress_rules
  key_name           = var.key_name
  root_volume_size           = var.root_volume_size
  root_volume_type           = var.root_volume_type
  root_volume_encryption      = var.root_volume_encryption
  iam_instance_profile = var.iam_instance_profile
  shutdown = var.shutdown
  stop = var.stop
  termination = var.termination
  instance_name      = var.instance_name
  userdata_s3_url    = var.userdata_s3_url
}
