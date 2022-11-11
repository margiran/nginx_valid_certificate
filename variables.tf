variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "nomad-1server-1client-sg-row8"
}

variable "server_instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"
}
# variable "zone_id" {
#   description = "bg.hashicorp-success.com zone id"
#   type        = string
#   default     = "Z10QHT9XL7XFZU"
# }
variable "record_name" {
  description = "mohammadreza.bg.hashicorp-success.com"
  type        = string
  default     = "reza.bg.hashicorp-success.com"
}
variable "hosted_zone_name" {
  description = "bg.hashicorp-success.com"
  type        = string
  default     = "bg.hashicorp-success.com"
}
variable "email" {
  description = "email "
  type        = string
  default     = "margiran@gmail.com"
}
variable "ami" {
  description = "The AMI to run in the cluster"
  type        = string
  default = "ami-0c55b159cbfafe1f0"
}
