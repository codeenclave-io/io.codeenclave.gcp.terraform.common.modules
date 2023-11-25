resource "random_string" "random" {
  length = 8
  special = false
}

locals {
    project_id = format("%s-%s-%s-%s", var.environment_type, var.region, var.data_classification, lower(random_string.random.result))
    service_account_id = format("service-account-%s", lower(random_string.random.result))
}

resource "google_folder" "department" {
    display_name    = var.department_id
    parent          = format("organizations/%s", var.organization_id)
}

resource "google_project" "project" {
    name        = var.name
    project_id  = local.project_id
    folder_id   = google_folder.department.name
    # probably should use labels to identify the various types of environments
    # e.g., 
    # "component": "result-store"
    # "environment-type": "prod/uat/dev"
    # "data-classification": "c1/c2/c3/c4"
    # "region": "emea/americas/apac"
    # 
    labels      = {
        environment_type = var.environment_type
        data_classification = var.data_classification
        region = var.region
    }
}

resource "google_service_account" "service_account" {
  account_id    = local.service_account_id
  display_name  = "Service Account"
  project = local.project_id
}

resource "google_service_account_key" "service_account_key" {
  service_account_id = google_service_account.service_account.name
}

data "google_service_account_key" "service_account_key" {
  name            = google_service_account_key.service_account_key.name
  public_key_type = "TYPE_X509_PEM_FILE"
}
