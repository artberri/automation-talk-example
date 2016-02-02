# automation-talk-example

```
azure group create tiki-example westeurope
azure group deployment create -vv --resource-group tiki-example --template-file infrastructure/templates/ubuntu-template.json --parameters-file infrastructure/sample-website.json
```

```
bundle install --path vendor/bundle
bundle exec librarian-puppet install 
```
