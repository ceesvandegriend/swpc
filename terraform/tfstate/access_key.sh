
RESOURCE_GROUP_NAME=rg-tfstate
STORAGE_ACCOUNT_NAME=tfstater0xk9

export ARM_ACCESS_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
