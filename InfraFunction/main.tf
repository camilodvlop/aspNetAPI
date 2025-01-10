provider "azurerm" {
  features {}
  subscription_id = "yoursubscriptionID"
}
# Crear un grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "CPTestRG"
  location = "East US"
}

# Crear una cuenta de almacenamiento
resource "azurerm_storage_account" "example" {
  name                     = "cpstorageaccount"
  resource_group_name       = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier               = "Standard"
  account_replication_type = "LRS"
}

# Crear un plan de servicio para las funciones
resource "azurerm_service_plan" "example" {
  name                = "cp-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name  
  os_type             = "Windows"  # Especifica el sistema operativo
  sku_name            = "Y1"      # Tipo de SKU para funciones (Dynamic)
}

# Crear la función de Windows
resource "azurerm_windows_function_app" "azfunctionapp" {
  name                       = "cp-function-app"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  service_plan_id        = azurerm_service_plan.example.id
  storage_account_name      = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  
  site_config {
    # Configuración para la aplicación
    app_command_line = ""  # Deja vacío si no usas un comando personalizado
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"
  }
}