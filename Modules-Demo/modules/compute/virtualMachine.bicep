
@description('Name of the virtual machine.')
param vmName string

@description('Location for all resources.')
param location string = 'westus'

@description('Environment for all resources.')
param environment string = 'dev'

@description('Size of VMs in the VM')
param vmSize string = 'Standard_DS1_v2'

@description('Image Publisher')
param imagePublisher string = 'Canonical'

@description('Image Offer')
param imageOffer string = 'UbuntuServer'

@description('Image SKU')
param imageSku string = '18.04-LTS'

@description('Image Version')
param imageVersion string = 'latest'

@description('Admin username on all VMs.')
param adminUsername string

@description('Admin password on all VMs.')
@secure()
param adminPassword string

@description('Subnet ID for the VMs')
param subnetId string

param diagStorageUri string


var vmFullName = 'ep-2-${vmName}-${environment}-${location}' 

resource linuxVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vmFullName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmFullName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: imageSku
        version: imageVersion
      }
      osDisk: {
        name: 'name'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: diagStorageUri
      }
    }
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: '${vmFullName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
}



output linuxVMName string = linuxVM.name

