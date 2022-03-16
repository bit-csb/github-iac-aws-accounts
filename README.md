# github-iac-aws-accounts
Github reusable workflow (iac-aws-accounts.yml) and composite action (action.yml) to create AWS Accounts

# Relation between Github Repos
```mermaid
flowchart LR
    id_t[iac-aws-accounts-t] --reusable workflow-->  id_rw[github-iac-aws-accounts]
    id_i[iac-aws-accounts-i] --reusable workflow-->  id_rw
    id_p[iac-aws-accounts-p] --reusable workflow-->  id_rw
    id_rw --composite action--> id_invite[github-azuread-invitation]
    id_rw --composite action--> id_ssh[github-configure-ssh]
    id_rw --composite action--> id_terraform[github-terraform-flow]
```

# Github Workflow Sequence
```mermaid
sequenceDiagram
    autonumber
    participant id_iac as iac-aws-accounts-(t|i|p)
    participant id_rw as github-iac-aws-accounts
    participant id_invite as github-azuread-invitation
    participant id_ssh as github-configure-ssh
    participant id_terraform as github-terraform-flow
    id_iac ->>  id_rw: Call reusable workflow
    id_rw -->> id_rw: Checkout calling repository
    id_rw -->> id_rw: Checkout github-iac-aws-accounts
    id_rw -->> id_rw: Setup Terraform
    id_rw ->> id_invite: Perform Invitations
    id_rw -->> id_rw: Copy files
    id_rw ->> id_ssh: Configure ssh
    id_rw -->> id_rw: Ensure account count does not decrease
    id_rw ->> id_terraform: Create AWS Accounts
    id_rw -->> id_rw: Ensure account count does not decrease
    id_rw ->> id_terraform: Configure AWS Accounts
    id_rw -->> id_rw: Copy files configuration files back
    id_rw -->> id_rw: Remove Non-Configuration files
    id_rw ->> id_iac: Update iac repo
```

# Terraform
The Terraform implementation relies on three parts of the calling repository:
* the file *./iac-aws-accounts/creation/accounts.tf* which contains details about the AWS Accounts that should be managed.
* the folder *environment* which contains tfvars files for both backend configuration and plan/apply variables for both AWS Account creation and configuration.

## Perform Invititations
The GitHub composite action call *Perform Invitations* relies on the file *./iac-aws-accounts/creation/accounts.tf*. The action ensure that each user mentioned in the file as owner of an AWS account is invited to current Azure AD tenant.

## Create AWS Accounts
The Terraform files in folder *creation* (from this repository) together the file *./iac-aws-accounts/creation/accounts.tf* (from the calling repository) cover the creation of AWS Accounts via Terraform module *bit-csb/terraform-aws-account-creation*. In addition to that a configuration file for each AWS Account is generated and stored in the folder *configuration*.

## Configure AWS Accounts
The Terraform files in folder *configuration* (from this repository) together the files from the previous creation step cover the configuration of each AWS Account via the Terraform Module *bit-csb/terraform-aws-account-configuration*.
