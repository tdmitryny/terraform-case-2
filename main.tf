terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mtc-rg-911" {
  name     = "mtc-rg-911-name"
  location = "eastus"
  tags = {
    envierment = "dev"
  }
}


resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-911"
  resource_group_name = azurerm_resource_group.mtc-rg-911.name
  location            = azurerm_resource_group.mtc-rg-911.location
  address_space       = ["10.123.0.0/16"]

  tags = {
    enviroment = "dev"
  }


}