terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.30.0"
    }
  }
}

provider "azurerm" {
  # Configuration options

  features{}
  subscription_id = "946461f2-5424-4818-bd06-010e5f3cd8c1" # Replace with your Azure subscription ID
}

resource "azurerm_resource_group" "lucky" {
  name     = "john"
  location = "canadacentral"
}

resource "azurerm_service_plan" "plan" {
  resource_group_name = azurerm_resource_group.lucky.name
  name                = "lucky-service-plan"
  location            = azurerm_resource_group.lucky.location
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "web" {
  resource_group_name = azurerm_resource_group.lucky.name
  name                = "lucky-web-app"
    location            = azurerm_resource_group.lucky.location
    service_plan_id     = azurerm_service_plan.plan.id
    site_config {
      application_stack {
        java_server = "JAVA"
        java_version = "21"
        java_server_version = "21"
      }
    }
}