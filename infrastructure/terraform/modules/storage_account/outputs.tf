output "primary_connection_string" {
  value       = azurerm_storage_account.sa.primary_connection_string
  description = "Primary connection string for the storage account."
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.sa.primary_blob_endpoint
}
