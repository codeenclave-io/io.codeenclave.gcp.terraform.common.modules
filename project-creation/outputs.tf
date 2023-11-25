output "project_id" {
  value = local.project_id
}

output "service_account_name" {
    value = local.service_account_id
}

output "service_account_key" {
    value = data.google_service_account_key.service_account_key.name
}