# Azure Managed Database - PostgreSQL flexible

This module creates an Azure PostgreSQL Flexible server .


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_configuration.extensions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_database.instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_flexible_server_firewall_rule.firewall_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule) | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [random_password.administrator_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_login"></a> [admin\_login](#input\_admin\_login) | (Optional) The Administrator login for the PostgreSQL Flexible Server | `string` | `"psqladmin"` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | (Optional) The Password associated with the administrator\_login for the PostgreSQL Flexible Server | `any` | n/a | yes |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | Map of authorized cidrs. | `map(string)` | n/a | yes |
| <a name="input_auto_grow_enabled"></a> [auto\_grow\_enabled](#input\_auto\_grow\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | The backup retention days for the PostgreSQL Flexible Server. Possible values are between 7 and 35 days. | `number` | `7` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | Map of databases configurations with database name as key and following available configuration option:<br>   *  (optional) charset: Valid PostgreSQL charset : https://www.postgresql.org/docs/current/multibyte.html#CHARSET-TABLE<br>   *  (optional) collation: Valid PostgreSQL collation : http://www.postgresql.cn/docs/13/collation.html - be careful about https://docs.microsoft.com/en-us/windows/win32/intl/locale-names?redirectedfrom=MSDN | <pre>map(object({<br>    charset   = optional(string, "UTF8")<br>    collation = optional(string, "en_US.utf8")<br>  }))</pre> | `{}` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | (Optional) The version of PostgreSQL Flexible Server to use. Possible values are 11,12, 13, 14 and 15 | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environnement name | `any` | n/a | yes |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | Azure extensions to be installed in the instance | `string` | `"null"` | no |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Is Geo-Redundant backup enabled on the PostgreSQL Flexible Server. | `bool` | `false` | no |
| <a name="input_high_availability"></a> [high\_availability](#input\_high\_availability) | The high availability mode for the PostgreSQL Flexible Server. | `string` | `"None"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | (Required) The name which should be used for this PostgreSQL Flexible Server. Changing this forces a new PostgreSQL Flexible Server to be created. | `list` | <pre>[<br>  "psql"<br>]</pre> | no |
| <a name="input_links"></a> [links](#input\_links) | Map of objects for private link with vnet | <pre>map(object({<br>    name    = string<br>    vnet_id = string<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the PostgreSQL Flexible Server should exist. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `"West Europe"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enable public network access for the PostgreSQL Flexible Server. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the PostgreSQL Flexible Server should exist. Changing this forces a new PostgreSQL Flexible Server to be created. | `any` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) The SKU Name for the PostgreSQL Flexible Server. | `string` | `"B_Standard_B2ms"` | no |
| <a name="input_storage_mb"></a> [storage\_mb](#input\_storage\_mb) | (Optional) The max storage allowed for the PostgreSQL Flexible Server | `number` | `32768` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the virtual network subnet to create the PostgreSQL Flexible Server. (Should not have any resource deployed in) | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | availability zone | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | Administrator password for PostgreSQL Flexible server. |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The FQDN of the PostgreSQL Flexible Server. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the PostgreSQL Flexible Server. |
<!-- END_TF_DOCS -->