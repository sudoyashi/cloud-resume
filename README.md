# Cloud resume challenge

Following the guide from Microsoft: [Host a static website in Azure Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website-how-to?tabs=azure-portal) using Powershell.

## To do list
- [X] Setup base HTML/CSS website
- [ ] Plan resume website layout, based on limiations of website. Do not over-engineer.
- [ ] Add resume information
- [ ] Add CDN
- [ ] Connect GitHub repo to Azure Web App
- [ ] Purchase or link to jekyll website?
- [ ] Setup HTTPS

```powershell
# Login to Azure
Connect-AzAccount

# Setup new rg, if does not exist already
$resourceGroup = 'cloud-resume'
$location = "westus"
$storageAccount = "cloudresume619"
az account set --subscription 'Training subscription'
az group list -otable
az group create --name $resourceGroup --location $location --tags "Env=dev"

# Setup storage account

az storage account create `
--name $storageAccount `
--resource-group $resourceGroup `
--location $location `
--sku Standard_LRS `
--kind StorageV2


# Enable static web hosing
az storage blob service-properties update `
--account-name $storageAccount `
--static-website `
--404-document "404.html" `
--index-document "index.html"

# Navigate to website files root directory if needed
az storage blob upload-batch -s "C:\Users\joshu\Documents\git\cloud-resume\" -d '$web' --account-name $storageAccount

# Print public URL
az storage account show -n $storageAccount `
-g $resourceGroup `
--query "primaryEndpoints.web" `
--output tsv

# Setup metrics
az monitor metrics 
```

Visit the current site here: [Cloud Static Website](https://cloudresume619.z22.web.core.windows.net/)