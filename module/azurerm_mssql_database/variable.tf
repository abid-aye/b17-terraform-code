variable "mssql_database" {
  description = "The name of the SQL Database."
  type        = string
}



variable "mssql_server_name" {
  description = "The name of the SQL Server where the database will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the SQL Database will be created."
  type        = string
}