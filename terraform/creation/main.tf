data "azuread_domains" "aad_domains" {
  admin_managed = true
  only_initial  = true
}

locals {
  default_domain = lower(data.azuread_domains.aad_domains.domains.*.domain_name[0])

  # Setup user map
  user_map = {
    for key, value in {
      for owner in toset(flatten([for key, value in local.account_map : value.owners])) : owner => regex("(?P<localPart>^[^@]+)@(?P<domain>.+$)", owner)
    } :
    key => {
      email = key,
      upn   = lower(value.domain) != local.default_domain ? "${lower(value.localPart)}_${lower(value.domain)}#EXT#@${local.default_domain}" : key
    }
  }
}

module "create-bit-aws-account" {
  source = "git@github-bit-csb:bit-csb/terraform-aws-account-creation?ref=0.2.1"

  for_each                    = local.account_map
  name                        = each.key
  email                       = each.value.email
  parentOU                    = lookup(local.ou, each.value.ou)
  billingThreshold            = each.value.billingThreshold
  billing_notifications_email = each.value.billingContact
  billing_alert_sns_topic_arn = data.aws_sns_topic.bit_aws_account_billing_alerts.arn
  user_provided_tags          = {}
  tags                        = each.value.tags
  owners                      = toset(each.value.owners)

  user_map = local.user_map

  providers = {
    aws.europe = aws.europe
    azuread    = azuread
  }
}
