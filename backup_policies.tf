resource "oci_core_volume_backup_policy" "weekly" {
  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID

  display_name  = "weekly-backups"
  freeform_tags = local.tags.defaults

  schedules {

    backup_type       = "FULL"
    period            = "ONE_WEEK"
    retention_seconds = 691200 # 8 days

    day_of_week = "SATURDAY"
    hour_of_day = 1
    time_zone   = "UTC"
  }
}

resource "oci_core_volume_group_backup" "web" {

  volume_group_id = oci_core_volume_group.web.id

  compartment_id = data.doppler_secrets.prod_main.map.OCI_GAIA_COMPARTMENT_PRODUCTION_ID

  display_name  = "web-volumes-backup"
  freeform_tags = local.tags.defaults
  type          = "FULL"
}
