
@description('sku of the container registry')
param sku string 

@description('location of the container registry')
param location string

@description('name of the container registry')
param acrName string 


resource acr 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' ={
  name     : acrName
  location : location
  sku      : sku
  properties: {
    adminUserEnabled: true
  }
}
