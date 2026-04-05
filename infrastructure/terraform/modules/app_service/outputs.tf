output "hostname" {
  value = azurerm_app_service.service.default_site_hostname
}

output "identity_principal_id" {
  value = azurerm_app_service.service.identity[0].principal_id
}
