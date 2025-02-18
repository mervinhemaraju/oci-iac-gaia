
# Output the public IP for web NLB reserved IP
output "web_nlb_reserved_ip" {
  value = oci_core_public_ip.web_nlb.ip_address
}

# Output the public IP for NAT gateway public ip
output "nat_gateway_public_ip" {
  value = oci_core_public_ip.prod_nat.ip_address
}

# Output the private IP for web-01
output "web_01_private_ip" {
  value = oci_core_instance.web_01.private_ip
}

# Output the public IP for web-01
output "web_01_public_ip" {
  value = oci_core_instance.web_01.public_ip
}

# Output the private IP for web-02
# output "web_02_private_ip" {
#   value = oci_core_instance.web_02.private_ip
# }

# # Output the public IP for web-02
# output "web_02_public_ip" {
#   value = oci_core_instance.web_02.public_ip
# }
