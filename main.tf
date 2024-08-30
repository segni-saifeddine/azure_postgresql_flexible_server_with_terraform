##############################################################
# This module creates a psql flexible server
##############################################################

resource "azurerm_postgresql_flexible_server" "this" {
  name                          = var.instance_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.engine_version
  public_network_access_enabled = var.public_network_access_enabled

  administrator_login    = var.admin_login
  administrator_password = coalesce(var.admin_password, one(random_password.administrator_password[*].result))

  zone                         = var.zone
  storage_mb                   = var.storage_mb
  sku_name                     = var.sku
  auto_grow_enabled            = var.auto_grow_enabled
  backup_retention_days        = var.backup_retention_days
  delegated_subnet_id          = var.public_network_access_enabled == false ? var.subnet_id :null
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  private_dns_zone_id          = var.public_network_access_enabled == false ? azurerm_private_dns_zone.this.id : null

  dynamic "high_availability" {
    for_each = var.high_availability != "None" ? [var.high_availability] : []
    content {
      mode = high_availability.value
    }
  }
  tags       = var.tags
  depends_on = [azurerm_private_dns_zone_virtual_network_link.dns_network_link]
  lifecycle {
    ignore_changes = [zone, high_availability[0].standby_availability_zone]
  }
}

resource "azurerm_postgresql_flexible_server_database" "instance" {
  for_each  = var.databases
  name      = each.key
  server_id = azurerm_postgresql_flexible_server.this.id
  charset   = each.value.charset
  collation = each.value.collation

}

resource "azurerm_postgresql_flexible_server_configuration" "extensions" {
  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.this.id
  value     = var.extensions
}

resource "azurerm_private_dns_zone" "this" {
  name                = "${var.instance_name}.private.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each              = var.links
  name                  = each.value.name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = each.value.vnet_id
  resource_group_name   = var.resource_group_name
}

resource "random_password" "administrator_password" {
  count   = var.admin_password == null ? 1 : 0
  length  = 32
  special = true
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "firewall_rules" {
  for_each         = var.subnet_id == null ? var.allowed_cidrs : {}
  name             = each.key
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = cidrhost(each.value, 0)
  end_ip_address   = cidrhost(each.value, -1)
}
