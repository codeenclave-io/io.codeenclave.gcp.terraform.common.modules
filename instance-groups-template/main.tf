resource "google_service_account" "default" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
}

resource "google_compute_instance_template" "default" {
  name        = var.name
  description = var.description

  // tags = ["foo", "bar"]

  labels = {
    environment = var.environment_type
  }

  instance_description = "description assigned to instances"
  machine_type         = "e2-medium"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  # disk {
  #   source_image      = "debian-cloud/debian-11"
  #   auto_delete       = true
  #   boot              = true
  #   // backup the disk every day
  #   resource_policies = [google_compute_resource_policy.daily_backup.id]
  # }

  // Use an existing disk resource
  disk {
    // Instance Templates reference disks by name, not self link
    source      = google_compute_disk.bootdisk.name
    auto_delete = false
    boot        = false
  }

  network_interface {
    network = "default"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

# data "google_compute_image" "my_image" {
#   family  = "debian-11"
#   project = "debian-cloud"
# }

resource "google_compute_disk" "bootdisk" {
  name  = "existing-disk"
  image = var.bootdisk_image
  size  = 10
  // type  = "pd-ssd"
  // zone  = "us-central1-a"
}

resource "google_compute_resource_policy" "daily_backup" {
  name   = "every-day-4am"
  region = "us-central1"
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "04:00"
      }
    }
  }
}