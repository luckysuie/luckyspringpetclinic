provider "azurerm" {
  features {}
  subscription_id = "946461f2-5424-4818-bd06-010e5f3cd8c1"
}

resource "azurerm_resource_group" "rg" {
  name     = "lucky-rg"
  location = "Canada Central"
}

resource "azurerm_service_plan" "asp" {
  name                = "java-app-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"           # Linux not available on F1/Shared
}

resource "azurerm_linux_web_app" "app" {
  name                = "luckywebapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = false
    application_stack {
      java_version = "17"              # Java SE (for Spring Boot JAR)
      java_server = "JAVA"          # Use Tomcat for Java web apps
      java_server_version = "17"    # Match with java_version
    }
  }
  app_settings = {
    WEBSITES_PORT = "8080"
  }

  tags = { environment = "dev" }
}