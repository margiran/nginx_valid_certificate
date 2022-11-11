output "server_public_ip" {
  description = "The public IP of the EC2 Instance "
  value       = aws_instance.server.public_ip
}

output "server_private_ip" {
  description = "The private IP of the EC2 Instance "
  value       = aws_instance.server.private_ip
}

output "ssh_server_public_ip" {
  description = "Command for ssh to the Server public IP of the EC2 Instance"
  value =  "ssh ubuntu@${aws_instance.server.public_ip} -i ~/.ssh/key_pair"
}

output "http_server_public_ip" {
  description = "Command for netdata to the Server public IP of the EC2 Instance"
  value = "http://${aws_instance.server.public_ip}"
}
output "https_server_public_ip" {
  description = "Command for netdata to the Server public IP of the EC2 Instance"
  value = "https://${aws_instance.server.public_ip}"
}

output "https_domain" {
  description = "Command for netdata to the Server public IP of the EC2 Instance"
  value = "https://${var.record_name}"
}
# output "certificate_pem" {
#   value = lookup(acme_certificate.certificate, "certificate_pem")
# }

# output "issuer_pem" {
#   value = lookup(acme_certificate.certificate, "issuer_pem")
# }

# output "private_key_pem" {
#   value = nonsensitive(lookup(acme_certificate.certificate, "private_key_pem"))
# }