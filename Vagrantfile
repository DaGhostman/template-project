# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "./root", "/var/www"

  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true #Show VM GUI on startup
    vb.memory = "768"
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "Updating packages list.\n\r\n\r"
    sudo apt-get update > /dev/null

    sudo sh /vagrant/src/general.sh

    sudo bash /vagrant/src/mysql.sh

    echo "Checking PHP"
    sudo sh /vagrant/src/php.sh
    sudo bash /vagrant/src/phptools.sh

    echo "Checking Apache"
    sudo sh /vagrant/src/apache.sh
    echo "DONE"

    if [ ! -f /vagrant/bootstrap/custom.sh ]; then
        echo "\tCreating bash script for user commands in 'bootstrap/custom.sh\n\r"
        touch /vagrant/bootstrap/custom.sh
        chmod +x /vagrant/bootstrap/custom.sh
        echo "#!/bin/sh\n# Place custom commands in this file, this script gets invoked right before the provisioning has finished." > /vagrant/bootstrap/custom.sh
    else
        echo "Running user land bash script.."
        /vagrant/bootstrap/custom.sh
        echo "Done"
    fi
  SHELL
end