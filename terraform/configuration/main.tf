# everything happens in the generated files
data "azurerm_storage_account" "aad_for_aws_sa" {
  name                = var.sa_name
  resource_group_name = var.rg_name
}

data "azurerm_storage_container" "aad_for_aws_container" {
  name                 = "deploymentscripts"
  storage_account_name = data.azurerm_storage_account.aad_for_aws_sa.name
}

resource "time_rotating" "aad_for_aws_sas_rotation" {
  rotation_days = 1
}

data "azurerm_storage_account_blob_container_sas" "aad_for_aws_sas" {
  connection_string = data.azurerm_storage_account.aad_for_aws_sa.primary_connection_string
  container_name    = data.azurerm_storage_container.aad_for_aws_container.name
  https_only        = true

  start = time_rotating.aad_for_aws_sas_rotation.rfc3339
  expiry = time_rotating.aad_for_aws_sas_rotation.rotation_rfc3339

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = true
  }
}
