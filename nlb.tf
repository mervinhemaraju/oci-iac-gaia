
# Create a network load balancer for web servers
resource "oci_network_load_balancer_network_load_balancer" "web" {
  compartment_id                 = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  display_name                   = "web"
  subnet_id                      = oci_core_subnet.public_web.id
  freeform_tags                  = local.tags.defaults
  is_preserve_source_destination = false
  is_private                     = false
  network_security_group_ids = [
    oci_core_network_security_group_security_rule.web.id
  ]
}

# NSG Backend Sets
resource "oci_network_load_balancer_backend_set" "web" {

  name                     = "http-backend-web"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.web.id
  policy                   = "FIVE_TUPLE"


  health_checker {

    protocol = "HTTP"

    interval_in_millis = 10000
    port               = 80
    # request_data        = var.backend_set_health_checker_request_data
    # response_body_regex = var.backend_set_health_checker_response_body_regex
    # response_data       = var.backend_set_health_checker_response_data
    # retries             = var.backend_set_health_checker_retries
    # return_code         = var.backend_set_health_checker_return_code
    # timeout_in_millis   = var.backend_set_health_checker_timeout_in_millis
    url_path = "/"
  }

  #Optional
  # ip_version = var.backend_set_ip_version
  # is_preserve_source = var.backend_set_is_preserve_source
}

# NSG Backends
resource "oci_network_load_balancer_backend" "web_01" {
  backend_set_name         = oci_network_load_balancer_backend_set.web.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.web.id
  port                     = 80

  is_backup  = false
  is_drain   = false
  is_offline = false
  name       = oci_core_instance.web_01.display_name
  target_id  = oci_core_instance.web_01.id
  weight     = 1
}

resource "oci_network_load_balancer_backend" "web_02" {
  backend_set_name         = oci_network_load_balancer_backend_set.web.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.web.id
  port                     = 80

  is_backup  = false
  is_drain   = false
  is_offline = false
  name       = oci_core_instance.web_02.display_name
  target_id  = oci_core_instance.web_02.id
  weight     = 1
}

# NSG Listeners
resource "oci_network_load_balancer_listener" "web" {
  #Required
  default_backend_set_name = oci_network_load_balancer_backend_set.web.name
  name                     = "web-listeners"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.web.id
  port                     = 80
  protocol                 = "TCP_AND_UDP"
}
