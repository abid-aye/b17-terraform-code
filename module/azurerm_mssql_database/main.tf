resource "azurerm_mssql_database" "sql_database" {
  name         = var.mssql_database
  server_id    = data.azurerm_mssql_server.server_id.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
}
    
    data "azurerm_mssql_server" "server_id" {
  name                = var.mssql_server_name
  resource_group_name = var.resource_group_name
  

}

