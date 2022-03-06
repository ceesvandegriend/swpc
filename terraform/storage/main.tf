terraform {
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.rg-name
  location = var.location
}

resource "random_id" "storage_account_name" {
  byte_length = 8
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "tfstate${lower(random_id.storage_account_name.hex)}"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}