variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "app_name" {
  description = "Application name, used in resource names"
  type        = string
  default     = "orders-web"
}

variable "operator_cidr" {
  description = "Your public IP in CIDR form, for SSH"
  type        = string
}

variable "image_tag" {
  description = "Image tag to run on the instance"
  type        = string
  default     = "c1b601b"
}
