terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "sttfbackend20260814abc"
    container_name       = "tfstate"
    key                  = "serverless-dev.tfstate"
  }
}