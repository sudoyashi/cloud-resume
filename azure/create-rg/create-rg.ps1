New-Item azuredeploy.json

az group deployment create -g cloud-website --template-file azuredeploy.json \