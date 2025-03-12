region          = "us-east-1"
ami_id          = "ami-05b10e08d247fb927"
instance_type   = "t2.micro"
subnet_id       = "subnet-00fc4bae2e83199f0"
create_security_group = true
vpc_id                = "vpc-0f355ea50c7c78ae4"
security_groups       = []
key_name        = "demo"
root_volume_size = "20"
root_volume_type = "gp3"
root_volume_encryption = "true"
ingress_rules   = [
 {
  from_port     = 22
  to_port       = 22
  protocol      = "tcp"
  cidr_blocks   = ["0.0.0.0/0"]
 } 
]
egress_rules   = [
 {
  from_port     = 0
  to_port       = 0
  protocol      = -1
  cidr_blocks   = ["0.0.0.0/0"]
 } 
]
shutdown = "stop"
stop  = "false"
termination = "false"
instance_name   = "sn"
userdata_s3_url = "s3://supernova-01/userdata.sh"
