output "resource_group_name" {
  description = "Name of the Azure resource group"
  value       = azurerm_resource_group.serverless.name
}

output "function_app_name" {
  description = "Name of the Azure Function App"
  value       = azurerm_linux_function_app.serverless.name
}

output "function_app_default_hostname" {
  description = "Default hostname of the Azure Function App"
  value       = azurerm_linux_function_app.serverless.default_hostname
}

output "storage_account_name" {
  description = "Name of the Azure Storage Account"
  value       = azurerm_storage_account.serverless.name
}

output "storage_account_primary_endpoint" {
  description = "Primary blob endpoint of the Storage Account"
  value       = azurerm_storage_account.serverless.primary_blob_endpoint
}