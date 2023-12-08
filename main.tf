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


resource "azurerm_subnet" "sub-net" {
  name                 = "sub-net-911"
  resource_group_name  = azurerm_resource_group.mtc-rg-911.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.123.1.0/24"]

}


resource "azurerm_network_security_group" "nsg-911" {
  name                = "nsg-911"
  location            = azurerm_resource_group.mtc-rg-911.location
  resource_group_name = azurerm_resource_group.mtc-rg-911.name

  tags = {
    enviroment = "dev"
  }

}


resource "azurerm_network_security_rule" "nsg-rule" {
  name                        = "nsg-rule-911"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.mtc-rg-911.name
  network_security_group_name = azurerm_network_security_group.nsg-911.name

}