# README storage

Execute once to create a remote storage the save the terraform state.


## Install

- [terraform](https://www.terraform.io/downloads)

- [azure-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

## Initialize

### az login

```shell
$ az login
A web browser has been opened at https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize. Please continue the login in the web browser. If no web browser is available or if the web browser fails to open, use device code flow with `az login --use-device-code`.
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "********-****-****-****-************",
    "id": "********-****-****-****-************",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Azure subscription Name",
    "state": "Enabled",
    "tenantId": "********-****-****-****-************",
    "user": {
      "name": "user@example.com",
      "type": "user"
    }
  }
]
```

### terraform init

```shell
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/azurerm...
- Finding latest version of hashicorp/random...
- Installing hashicorp/azurerm v2.98.0...
- Installed hashicorp/azurerm v2.98.0 (signed by HashiCorp)
- Installing hashicorp/random v3.1.0...
- Installed hashicorp/random v3.1.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

## Execute

### Terraform plan

```shell
$ terraform plan -out terraform.tfplan
random_id.storage_account_name: Refreshing state... [id=FYTIAzEA3VI]
azurerm_resource_group.resource_group: Refreshing state... [id=/subscriptions/********-****-****-****-************/resourceGroups/rg-terraform]
azurerm_storage_account.storage_account: Refreshing state... [id=/subscriptions/********-****-****-****-************/resourceGroups/rg-terraform/providers/Microsoft.Storage/storageAccounts/tfstate1584c8033100dd52]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the
last "terraform apply":

  # azurerm_resource_group.resource_group has changed
  ~ resource "azurerm_resource_group" "resource_group" {
        id       = "/subscriptions/********-****-****-****-************/resourceGroups/rg-terraform"
        name     = "rg-terraform"
      + tags     = {}
        # (1 unchanged attribute hidden)
    }


Unless you have made equivalent changes to your configuration, or ignored the
relevant attributes using ignore_changes, the following plan may include
actions to undo or respond to these changes.

───────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # azurerm_storage_account.storage_account will be updated in-place
  ~ resource "azurerm_storage_account" "storage_account" {
        id                                = "/subscriptions/********-****-****-****-************/resourceGroups/rg-terraform/providers/Microsoft.Storage/storageAccounts/tfstate1584c8033100dd52"
        name                              = "tfstate1584c8033100dd52"
      ~ tags                              = {
          - "environment" = "staging" -> null
        }
        # (34 unchanged attributes hidden)




        # (4 unchanged blocks hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────

Saved the plan to: terraform.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "terraform.tfplan"
```

### Terraform apply

```shell
$ terraform apply terraform.tfplan
azurerm_storage_account.storage_account: Modifying... [id=/subscriptions/********-****-****-****-************/resourceGroups/rg-terraform/providers/Microsoft.Storage/storageAccounts/tfstate1584c8033100dd52]
azurerm_storage_account.storage_account: Modifications complete after 3s [id=/subscriptions/********-****-****-****-************/resourceGroups/rg-terraform/providers/Microsoft.Storage/storageAccounts/tfstate1584c8033100dd52]

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

storage_account_name = "tfstate1584c8033100dd52"
```