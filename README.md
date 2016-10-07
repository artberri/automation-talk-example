# Automation: Infrastruture, Software & Deploy

Source code of the slides for the presentation: Automation: Infrastruture, Software & Deploy. Includes also the example shown during the presentation, which is explained bellow.

## Requeriments

- Ruby and Rubygems
- Node.js
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [Terraform](https://www.terraform.io/intro/getting-started/install.html)
- [Packer](https://www.packer.io/)

## Dev

Just once:

```
gem install bundler
bundle install --path vendor/bundle
```

After changing puppet modules:

```
bundle exec librarian-puppet install
```

## Create new image

```
packer validate packer/example.json
packer build packer/example.json
```

This will create a vagrant box to allow you test it locally and an Amazon AMI that you can use to create an EC2 instance to
deploy your app.

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

The passwords for the machine should not be in the repo, neither in a public repo (of course) but this is just an example.

### Application deployment

In this case I've used [Travis](https://travis-ci.org/artberri/automation-talk-example) to build and deploy the application. It's really simple to use, it's free for Open Source projects and you can [script your build](.travis.yml).

As a task runner for making easy the build, the test and the deploy [Grunt](http://gruntjs.com/) is used.
