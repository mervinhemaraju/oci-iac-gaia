
# Output the public IP for web-01
output "web-01-public-ip" {
  value = oci_core_instance.web_01.public_ip
}

# Output the private IP for web-01
output "web-01-private-ip" {
  value = oci_core_instance.web_01.private_ip
}


# Output the public IP for web-02
output "web-02-public-ip" {
  value = oci_core_instance.web_02.public_ip
}

# Output the private IP for web-02
output "web-02-private-ip" {
  value = oci_core_instance.web_02.private_ip
}
