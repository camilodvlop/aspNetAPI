provider "azurerm" {
  features {}
  subscription_id = "youtsubcription Id from azure"
}
resource "azurerm_cosmosdb_account" "cosmosdb_instance" {
  name                = "test-cosmosdb-account"       # Nombre único de la cuenta Cosmos DB
  location            = "East US"                    # Ubicación de la base de datos
  resource_group_name = "MyResourceGroup"            # El grupo de recursos que ya creaste

  # Habilitar características necesarias, como el tipo de API (SQL API en este caso)
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"          # Cosmos DB con SQL API

  consistency_policy {
    consistency_level = "Session"  # Nivel de consistencia (puedes elegir otro según tus necesidades)
  }

  # Habilitar la redundancia geográfica en varias regiones
  geo_location {
    location          = "East US"
    failover_priority = 0
  }

  geo_location {
    location          = "West US"
    failover_priority = 1
  }
  
}