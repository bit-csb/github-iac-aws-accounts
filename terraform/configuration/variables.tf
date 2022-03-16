variable "billing_notifications_email" {
  type    = set(string)
}

variable "profilename" {
  type    = string
}

variable "subscription" {
  type        = string
  description = "Subscription ID of the service principal used by terraform"
}

variable "bit_csb_administrator_group_id" {
  type        = string
  description = "ID of Azure AD group containing the BIT CSB Administrators"
}

variable "new_aws_enterpries_app_script_uri" {
  type        = string
  description = "location"
}

variable "synchonzication_job_script_uri" {
  type        = string
  description = "URI of script for sychnronising AWS IAM and Azure AD"
}

variable "claims_mapping_policy_id" {
  type        = string
  description = "claims mapping policy"
}

variable "client_secret" {
  type        = string
  description = "Client secret of the service principal used by terraform "
  sensitive   = true
}

variable "location" {
  type        = string
  description = "Location for resource group and storage account"
  default     = "switzerlandnorth"
}

variable "rg_name" {
  type        = string
  description = "Name of resource group"
  default = "ea_for_aws"
}

variable "sa_name" {
  type        = string
  description = "Name of storage account"
}

variable "notification_email_address" {
  type        = string
  description = "Email address for notification of certificate expiration"
}
