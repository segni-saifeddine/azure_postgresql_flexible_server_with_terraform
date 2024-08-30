##############################################################
# This module creates a PSQL flexible server
##############################################################

variable "instance_name" {
  description = "(Required) The name which should be used for this PostgreSQL Flexible Server. Changing this forces a new PostgreSQL Flexible Server to be created."
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the PostgreSQL Flexible Server should exist. Changing this forces a new PostgreSQL Flexible Server to be created."
}


variable "location" {
  description = "(Required) The Azure Region where the PostgreSQL Flexible Server should exist. Changing this forces a new PostgreSQL Flexible Server to be created."
  default     = "West Europe"
}

variable "engine_version" {
  description = "(Optional) The version of PostgreSQL Flexible Server to use. Possible values are 11,12, 13, 14 and 15"
  type        = string
}

variable "sku" {
  description = "(Optional) The SKU Name for the PostgreSQL Flexible Server."
  default     = "B_Standard_B2ms"
}

variable "storage_mb" {
  description = "(Optional) The max storage allowed for the PostgreSQL Flexible Server"
  default     = 32768
}

variable "admin_login" {
  description = "(Optional) The Administrator login for the PostgreSQL Flexible Server"
  default     = "psqladmin"
}

variable "admin_password" {
  description = "(Optional) The Password associated with the administrator_login for the PostgreSQL Flexible Server"
  sensitive   = true
}
variable "zone" {
  description = "availability zone"
}
variable "subnet_id" {
  description = "The ID of the virtual network subnet to create the PostgreSQL Flexible Server. (Should not have any resource deployed in)"
  type        = string
  default     = null
}
variable "env" {
  description = "Environnement name"
}

variable "auto_grow_enabled" {
  default = false
}
variable "backup_retention_days" {
  description = "The backup retention days for the PostgreSQL Flexible Server. Possible values are between 7 and 35 days."
  default     = 7
}
variable "high_availability" {
  description = "The high availability mode for the PostgreSQL Flexible Server."
  default     = "None"
}
variable "geo_redundant_backup_enabled" {
  description = "Is Geo-Redundant backup enabled on the PostgreSQL Flexible Server. "
  default     = false
}
variable "extensions" {
  description = "Azure extensions to be installed in the instance"
  default     = "null"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
}
variable "databases" {
  description = <<EOF
  Map of databases configurations with database name as key and following available configuration option:
   *  (optional) charset: Valid PostgreSQL charset : https://www.postgresql.org/docs/current/multibyte.html#CHARSET-TABLE
   *  (optional) collation: Valid PostgreSQL collation : http://www.postgresql.cn/docs/13/collation.html - be careful about https://docs.microsoft.com/en-us/windows/win32/intl/locale-names?redirectedfrom=MSDN
  EOF
  type = map(object({
    charset   = optional(string, "UTF8")
    collation = optional(string, "en_US.utf8")
  }))
  default = {}
}

variable "links" {
  description = "Map of objects for private link with vnet"
  type = map(object({
    name    = string
    vnet_id = string
  }))
  default = {}
}


variable "allowed_cidrs" {
  description = "Map of authorized cidrs."
  type        = map(string)
}

variable "public_network_access_enabled" {
  description = "Enable public network access for the PostgreSQL Flexible Server."
  type        = bool
  default     = false
  validation {
    condition     = var.subnet_id != null && var.public_network_access_enabled == true
    error_message = "public_network_access_enabled must be set to false when delegated_subnet_id and private_dns_zone_id have a valu"
  }
}