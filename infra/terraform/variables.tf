variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-2"
}

variable "key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
}

