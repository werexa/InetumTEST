terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.84.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.2"
    }

  }

  backend "azurerm" {

  }
}

provider "azurerm" {
  #   skip_provider_registration = true
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

provider "random" {
  # Configuration options
}

data "azurerm_client_config" "current" {}

 
resource "azurerm_resource_group" "rg_inetumacademy" {
  name     = "rg-${var.stage}-${var.locationShort}-01"
  location = var.location
}
 
### AKS Cluster
 
resource "azurerm_kubernetes_cluster" "aks_inetumacademy" {
  name                = "aks-${var.stage}-${var.locationShort}-01"
  location            = azurerm_resource_group.rg_inetumacademy.location
  resource_group_name = azurerm_resource_group.rg_inetumacademy.name
  dns_prefix          = "aks-${var.stage}-${var.locationShort}-01-dns"
  kubernetes_version  = "1.22.6"
 
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }
 
  identity {
    type = "SystemAssigned"
  }
 
}
