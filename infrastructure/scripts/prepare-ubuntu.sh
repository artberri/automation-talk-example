#!/bin/bash

echo "[Provisioning Script] - Start"

[[ -v HOME ]] || export HOME=/root
SERVER_NAME=$(hostname -f)
UBUNTU_CODE_NAME=`lsb_release --codename | cut -f2`

echo "[Provisioning Script] - [Part 1 of 5] - Common fixes"
# Fix 'stdin is not a tty'
sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile

echo "[Provisioning Script] - [Part 2 of 5] - Installing Puppet"
wget "https://apt.puppetlabs.com/puppetlabs-release-$UBUNTU_CODE_NAME.deb"
dpkg -i "puppetlabs-release-$UBUNTU_CODE_NAME.deb"
apt-get update
apt-get install -y puppet-common=3.8.2-1puppetlabs1 puppet=3.8.2-1puppetlabs1
service puppet stop

echo "[Provisioning Script] - [Part 3 of 5] - Cloning the puppet repo"
apt-get install -y git
cd /data
git clone https://github.com/artberri/automation-talk-example.git puppet

echo "[Provisioning Script] - [Part 4 of 5] - Cloning the puppet repo"
apt-get install -y ruby-full ruby1.9.1-dev build-essential
cd /data/puppet
gem install bundler
bundle install
bundle exec librarian-puppet install

echo "[Provisioning Script] - [Part 5 of 5] - Running puppet"
puppet apply --modulepath=/data/puppet/modules -e "include roles::websites::sample"

echo "[Provisioning Script] - End"
