
@description('The location of the storage account')
param location string 

@description('The name of the storage account')
param storageAccountName string


var standardStorageAccountName = 'sa${storageAccountName}${uniqueString(resourceGroup().id)}'


resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: standardStorageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

output storageAccountName string = storageaccount.name
output storageAccountId string = storageaccount.id

