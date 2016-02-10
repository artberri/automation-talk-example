# Automation: Infrastruture, Software & Deploy

Source code of the slides for the presentation: Automation: Infrastruture, Software & Deploy. Includes also the example shown during the presentation, which is explained bellow.

## Run the slides locally

These slides has been done using [Reveal.js](https://github.com/hakimel/reveal.js/). To run them locally just run:

```
npm install -g grunt-cli
npm install
grunt serve
```

## Example

### Infraestructure provisioning

This example uses [Azure Resource Manager](https://azure.microsoft.com/en-us/documentation/articles/resource-group-overview/) to create the infraestructure automatically. 

It should create a virtual machine with an attached disk and assign a public IP. To host this simple 'app' probably should be better to just create a 'WebApp' (PaaS) in Azure, but in that case I won't need to make the software provisioning that I want to show in the next point.

You need an Azure account and you need to be logged using the [azure-cli](https://www.npmjs.com/package/azure-cli) tool. After that you can trigger the provisioning with the following commands:

```
azure group create tiki-example westeurope
azure group deployment create --resource-group tiki-example --template-file infrastructure/templates/ubuntu-template.json --parameters-file infrastructure/sample-website.json
```

You can see the code source used in the [infrastructure](infrastructure) folder.

### Software provisioning

To automate the software provisioning in this example I used [Puppet](https://puppetlabs.com/). 

Because I wanted to create an standalone example, I have automated the software provisioning process running `puppet apply` with a [script](infrastructure/scripts/prepare-ubuntu.sh), that is triggered when the infraestructure provisioning finishes. This is not the proper way, but it works for this example, in a production environment you should have a [client/server](https://puppetlabs.com/blog/deploying-puppet-in-client-server-standalone-and-massively-scaled-environments) structure (with a puppet master).

You can see the code source used in the [software](software) folder.

### Application deployment

In this case I've used [Travis](https://travis-ci.org/artberri/automation-talk-example) to build and deploy the application. It's really simple to use, it's free for Open Source projects and you can [script your build](.travis.yml). 

As a task runner for making easy the build, the test and the deploy [Grunt](http://gruntjs.com/) is used.
