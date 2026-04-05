output "resource_group" {
  value = module.resource_group.name
}

output "storage_connection_string" {
  value     = module.storage.primary_connection_string
  sensitive = true
}

output "key_vault_uri" {
  value = module.key_vault.vault_uri
}

output "app_service_hostname" {
  value = module.app_service.hostname
}
