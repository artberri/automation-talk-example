# automation-talk-example

```
azure group create tiki-example westeurope
azure group deployment create -vv --resource-group tiki-example --template-file infrastructure/templates/linux-template.json --parameters-file infrastructure/sample-website.json
```
