resource "oci_core_volume_backup_policy" "weekly" {
  compartment_id = local.values.compartments.production

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

  compartment_id = local.values.compartments.production

  volume_group_id = oci_core_volume_group.web.id

  display_name  = "web-volumes-backup"
  freeform_tags = local.tags.defaults
  type          = "FULL"
}
