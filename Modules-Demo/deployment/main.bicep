// Create multiple storage accounts for each region

@minLength(3)
@maxLength(24)
@description('Generic storage account name for project')
param stgName string

@description('Azure region location for deployment.')
param azureRegion string

@description('SKU for ACR')
param acrsku string

@description('acr name')
param acrname string


module cloudStorageMain '../modules/storage-w-parametrization.bicep' = {
  name: 'cloudstoragemain'
  params: {
    stgName: '${stgName}stg01'
    location: azureRegion
  }
}

module cloudStorageLogs '../modules/storage-w-parametrization.bicep' = {
  name: 'cloudstoragelogs'
  params: {
    stgName: '${stgName}stg02'
    location: azureRegion
  }
}

module webAppMain '../modules/web-app-parameterized.bicep' = {
  name: 'webAppMain'
  params: {
    location: azureRegion
  }
}

module acr '../modules/acr-deploy.bicep' = {
  name: 'acr'
  params: {
    location: azureRegion
    sku: acrsku
    acrName: acrname
  }
}
