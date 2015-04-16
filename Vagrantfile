# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "./root", "/var/www"

  config.vm.provider "virtualbox" do |vb|

    #vb.gui = true #Show VM GUI on startup
    vb.memory = "512"
  end
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install mysql-server-5.5 -y
    sudo apt-get install -y php5 php5-mcrypt php5-sqlite php5-xdebug sqlite3 git
  SHELL
end