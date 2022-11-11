variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "nomad-1server-1client-sg-row8"
}

variable "ami" {
  description = "The AMI to run in the cluster"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "server_instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "record_name" {
  description = "dns recored will be add to route53"
  type        = string
  default     = "reza.bg.hashicorp-success.com"
}

variable "hosted_zone_name" {
  description = "hosted zone name "
  type        = string
  default     = "bg.hashicorp-success.com"
}

variable "email" {
  description = "an email use for lets encrypt "
  type        = string
  default     = "margiran@gmail.com"
}
