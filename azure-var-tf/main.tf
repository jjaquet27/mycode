# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.loc
}

resource "azurerm_virtual_network" "example" {
  name                = var.vnetname
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnetaddressspace
  dns_servers         = var.dnsservers

  subnet {
    name           = var.subnetname
    address_prefix = var.subnetaddress
  }
}
# this is now an "input" value 
variable "loc" {
  type    = string
  default = "westus2"
}

variable "rgname" {
  type    = string
  default = "terraformlabrg"
}

variable "vnetname" {
  type    = string
  default = "tflabvnet1"
}

variable "subnetname" {
  type    = string
  default = "tflabsubnet1"
}

variable "vnetaddressspace" {
  type    = list(any)
  default = ["10.0.0.0/16"]
}

variable "dnsservers" {
  type    = list(any)
  default = ["10.0.0.4"]
}

variable "subnetaddress" {
  type    = string
  default = "10.0.1.0/24"
}
