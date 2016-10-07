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

## Terraform

```
cd terraform
terraform plan
terraform apply
cd -
```

## Run the slides locally

These slides has been done using [Reveal.js](https://github.com/hakimel/reveal.js/). To run them locally just run:

```
npm install -g grunt-cli
npm install
grunt serve
```
