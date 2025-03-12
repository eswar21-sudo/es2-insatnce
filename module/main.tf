# 🔹 Create IAM Role for EC2 Instance
resource "aws_iam_role" "ec2_role" {
  name = "EC2S3AccessRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# 🔹 Attach S3 Read Access Policy to IAM Role
resource "aws_iam_policy" "s3_read_policy" {
  name        = "S3ReadAccessPolicy"
  description = "Allow EC2 to read objects from S3"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::supernova-01/*"
    }
  ]
}
EOF
}

# 🔹 Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_read_policy.arn
}

# 🔹 Create IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.ec2_role.name
}


# Create Security group
resource "aws_security_group" "ec2_sg" {
   vpc_id = var.vpc_id

    dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
     }
    }


      dynamic "egress" {
      for_each = var.egress_rules
      content {
       from_port   = egress.value.from_port
       to_port     = egress.value.from_port
       protocol    = egress.value.protocol
       cidr_blocks = egress.value.cidr_blocks
     }
   }

      tags = {
        Name = "${var.instance_name}-sg"
      }
   }


resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  security_groups        = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  root_block_device {
     volume_size           = var.root_volume_size
     volume_type           = var.root_volume_type
     encrypted             = var.root_volume_encryption
     delete_on_termination = true # Ensures volume is deleted when the instance is terminate
   }
  instance_initiated_shutdown_behavior = var.shutdown
  disable_api_stop = var.stop 
  disable_api_termination = var.termination
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              echo "Downloading script from S3..."
              aws s3 cp ${var.userdata_s3_url} /tmp/userdata.sh
              chmod +x /tmp/userdata.sh
              /tmp/userdata.sh
   EOF

  tags = {
    Name = var.instance_name
  }
}
