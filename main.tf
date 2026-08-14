terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "serverless" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "serverless" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.serverless.name
  location                 = azurerm_resource_group.serverless.location
  account_tier              = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  tags = {
    environment = var.environment
    project     = "serverless-demo"
  }
}


resource "azurerm_storage_container" "images" {
  name                  = "images"
  storage_account_id    = azurerm_storage_account.serverless.id
  container_access_type = "private"
}

resource "azurerm_service_plan" "serverless" {
  name                = "${var.project_name}-plan"
  resource_group_name = azurerm_resource_group.serverless.name
  location            = azurerm_resource_group.serverless.location

  os_type  = "Linux"
  sku_name = "Y1"
}

resource "azurerm_linux_function_app" "serverless" {
  name                = var.function_app_name
  resource_group_name = azurerm_resource_group.serverless.name
  location            = azurerm_resource_group.serverless.location

  storage_account_name       = azurerm_storage_account.serverless.name
  storage_account_access_key = azurerm_storage_account.serverless.primary_access_key
  service_plan_id            = azurerm_service_plan.serverless.id

  site_config {
    application_stack {
      python_version = "3.11"
    }
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "python"
  }

  tags = {
    environment = var.environment
  }
}

// Output the function app's default hostname