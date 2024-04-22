
# Create a network load balancer for web servers
resource "oci_network_load_balancer_network_load_balancer" "web" {
  compartment_id                 = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID
  display_name                   = "web"
  subnet_id                      = oci_core_subnet.public_web.id
  freeform_tags                  = local.tags.defaults
  is_preserve_source_destination = false
  is_private                     = false
  network_security_group_ids = [
    oci_core_network_security_group.web.id
  ]

  reserved_ips {
    id = oci_core_public_ip.web_nlb.id
  }
}

# NSG Backend Sets
resource "oci_network_load_balancer_backend_set" "https" {

  name                     = "https-backend"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.web.id
  policy                   = "FIVE_TUPLE"


  health_checker {

    protocol = "HTTP"

    interval_in_millis  = 10000
    port                = 80
    response_body_regex = "OK"
    retries             = 3
    return_code         = 200
    timeout_in_millis   = 3000
    url_path            = "/health"
  }

  is_preserve_source = false
}

# NSG Backends
resource "oci_network_load_balancer_backend" "web_01" {
  backend_set_name         = oci_network_load_balancer_backend_set.https.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.web.id
  port                     = 443

  is_backup  = false
  is_drain   = false
  is_offline = false
  name       = oci_core_instance.web_01.display_name
  target_id  = oci_core_instance.web_01.id
  weight     = 1
}

resource "oci_network_load_balancer_backend" "web_02" {
  backend_set_name         = oci_network_load_balancer_backend_set.https.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.web.id
  port                     = 443

  is_backup  = false
  is_drain   = false
  is_offline = false
  name       = oci_core_instance.web_02.display_name
  target_id  = oci_core_instance.web_02.id
  weight     = 1
}

# NSG Listeners
resource "oci_network_load_balancer_listener" "https" {
  default_backend_set_name = oci_network_load_balancer_backend_set.https.name
  name                     = "https-listeners"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.web.id
  port                     = 443
  protocol                 = "TCP_AND_UDP"
}
