#!/bin/bash

echo "[Provisioning Script] - Start"

SERVER_NAME=$(hostname -f)
UBUNTU_CODE_NAME=`lsb_release --codename | cut -f2`

echo "[Provisioning Script] - [Part 1 of 2] - Common fixes"
# Fix 'stdin is not a tty'
sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile

echo "[Provisioning Script] - [Part 2 of 2] - Installing Puppet"
wget "https://apt.puppetlabs.com/puppetlabs-release-$UBUNTU_CODE_NAME.deb"
dpkg -i "puppetlabs-release-$UBUNTU_CODE_NAME.deb"
apt-get update
apt-get install -y puppet-common=3.8.2-1puppetlabs1 puppet=3.8.2-1puppetlabs1
service puppet stop

echo "[Provisioning Script] - End"
