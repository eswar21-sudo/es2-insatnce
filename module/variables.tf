variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the instance"
  type        = string
}

variable "key_name" {
  description = "SSH Key Pair name"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM role for the EC2 instance"
  type        = string
  default     = ""
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "root_volume_size" {
 description = "size of the volume"
 type = string

}

variable "root_volume_type" {
 description = "type of volume"
 type = string

}

variable "root_volume_encryption" {
 description = "Enable encryption on root volume"
 type = string

}

variable "shutdown" {
 description = "When shutdown the instance it will stop or terminate"
 type = string

}

variable "stop" {
  description = "Protect Instance accidentally stop"
  type = bool

}

variable "termination" {
 description = "Instance can't be terminated"
 type = bool

}

variable "userdata_s3_url" {
  description = "Pre-signed URL of the user data script in S3"
  type        = string
}
variable "create_security_group" {
  description = "Boolean flag to create a new Security Group"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC ID where Security Group will be created"
  type        = string
}

variable "security_groups" {
  description = "List of existing Security Group IDs (if using existing SG)"
  type        = list(string)
  default     = []
}

variable "ingress_rules" {
 description = "List of ingress rules"
 type        = list(object({
   from_port = number
   to_port   = number
   protocol  = string
   cidr_blocks = list(string)
  }))
}



variable "egress_rules" {
 description = "List of egress rules"
 type        = list(object({
   from_port = number
   to_port   = number
   protocol  = string
   cidr_blocks = list(string)
  }))
}


