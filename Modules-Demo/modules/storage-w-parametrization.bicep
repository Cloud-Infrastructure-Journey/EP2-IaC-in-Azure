// storage-w-parametrization.bicep

@description('The name of the storage account')
param stgName string // = 'ep1cloudjourneyazure'

@description('The location of the storage account')
param location string // = resourceGroup().id

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: stgName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
