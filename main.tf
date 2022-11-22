terraform {
  cloud {
    organization = "democheck"

    workspaces {
      name = "cli_tf"
    }
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {

  tenant_id       = "78e373a2-3114-4412-8788-b133d82b0e3c"
  subscription_id = "dc055a5d-5ac7-4c4a-93e8-5772563c860b"
  client_id       = "e1657a14-4509-4b56-94d9-5599e39ec521"
  client_secret   = "FJv8Q~tGhyVeCsHFkfaBhXYDXYZu_Q06GYrGTaug"

  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_servicebus_namespace" "example" {
  name                = "demo-servicebus-namespace1181"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"

  tags = {
    source = "terraform"
  }
}

resource "azurerm_servicebus_queue" "example" {
  name         = "demo_servicebus_queue"
  namespace_id = azurerm_servicebus_namespace.example.id

  enable_partitioning = true
}