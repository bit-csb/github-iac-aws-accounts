data "aws_sns_topic" "bit_aws_account_billing_alerts" {
  name = "bit_aws_account_billing_alerts"
}

data "aws_organizations_organization" "org" {}

data "aws_organizations_organizational_units" "ou" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

data "aws_organizations_organizational_units" "ou_security" {
  parent_id = local.ou_toplevel["security"]
}

data "aws_organizations_organizational_units" "ou_workloads" {
  parent_id = local.ou_toplevel["workloads"]
}

locals {
  ou_toplevel = {
    "policystaging" = data.aws_organizations_organizational_units.ou.children[index(data.aws_organizations_organizational_units.ou.children.*.name, "PolicyStaging")].id
    "security"      = data.aws_organizations_organizational_units.ou.children[index(data.aws_organizations_organizational_units.ou.children.*.name, "Security")].id
    "suspended"     = data.aws_organizations_organizational_units.ou.children[index(data.aws_organizations_organizational_units.ou.children.*.name, "Suspended")].id
    "transitional"  = data.aws_organizations_organizational_units.ou.children[index(data.aws_organizations_organizational_units.ou.children.*.name, "Transitional")].id
    "workloads"     = data.aws_organizations_organizational_units.ou.children[index(data.aws_organizations_organizational_units.ou.children.*.name, "Workloads")].id
  }

  ou_security = {
    "security.prod" = data.aws_organizations_organizational_units.ou_security.children[index(data.aws_organizations_organizational_units.ou_security.children.*.name, "Prod")].id
  }
  ou_workloads = {
    "workloads.prod" = data.aws_organizations_organizational_units.ou_workloads.children[index(data.aws_organizations_organizational_units.ou_workloads.children.*.name, "Prod")].id
  }

  ou = merge(local.ou_toplevel, local.ou_security, local.ou_workloads)

}