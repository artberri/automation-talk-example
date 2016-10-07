#!/bin/bash -v
export PATH=$PATH:/usr/local/bin

echo "[Provisioning Script] Adding the PuppetLabs Source.."
wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
sudo apt-get update

echo "[Provisioning Script] Installing Required base packages.."
sudo apt-get install -y git ruby build-essential ruby-dev

echo "[Provisioning Script] Installing Puppet.."
sudo apt-get install puppet -y

echo "[Provisioning Script] Stopping the Puppet Service.."
sudo service puppet stop
