provider "azurerm" { 
features {} 
subscription_id = "946461f2-5424-4818-bd06-010e5f3cd8c1"
} 
resource "azurerm_resource_group" "rg" { 
name     = "rg-dotnet-app" 
location = "Canada Central" 
} 
resource "azurerm_service_plan" "asp" { 
name                = "java-app-plan" 
location            = azurerm_resource_group.rg.location 
resource_group_name = azurerm_resource_group.rg.name 
sku_name = "F1" # Free tier 
os_type  = "Windows" 
} 
resource "azurerm_linux_web_app" "app" { 
name                = "luckywebapp" 
location            = azurerm_resource_group.rg.location 
resource_group_name = azurerm_resource_group.rg.name 
service_plan_id     = azurerm_service_plan.asp.id 

site_config {
  always_on = false
}
tags = { 
environment = "dev" 
} 
}