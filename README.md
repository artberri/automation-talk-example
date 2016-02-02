# automation-talk-example

```
azure group create tiki-example westeurope
azure group deployment create -vv --resource-group tiki-example --template-file infrastructure/templates/ubuntu-template.json --parameters-file infrastructure/sample-website.json
```

{"error":{"code":"InvalidTemplate","message":"Unable to process template language expressions for resource '/subscriptions/8baacd52-879c-4093-899c-5dea5d54c897/resourceGroups/tiki-example/providers/Microsoft.Compute/virtualMachines/MyUbuntuVM/extensions/installPuppet' at line '1' and column '5044'. 'The template parameter 'MachinePrefix' is not found. Please see http://aka.ms/arm-template/#parameters for usage details.'"}}
RESOURCEMyUbuntuVM/installPuppet
