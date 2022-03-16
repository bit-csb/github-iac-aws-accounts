locals {
  sas = data.azurerm_storage_account_blob_container_sas.aad_for_aws_sas.sas
}

locals {
  new_aws_enterpries_app_script_uri = "https://${var.sa_name}.blob.core.windows.net/deploymentscripts/New-AWSEnterpriseApp.ps1?${local.sas}"
  synchonzication_job_script_uri    = "https://${var.sa_name}.blob.core.windows.net/deploymentscripts/Enable-Provisioning.ps1?${local.sas}"
}
