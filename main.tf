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

