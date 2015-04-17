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
    echo "Preparing to install MySQL Server v5.5"
    debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
    sudo apt-get install mysql-server-5.5 -y > /dev/null
    echo "Package installed successfully\n\r"
    echo "Waiting 7s for the service to start and continue with the configuration."
    sleep 7

    UP=$(grep mysql | wc -l);
    if [ "$UP" -ne 1 ]; then
        echo "MySQL Server not running. Continuing!"
    else
        echo "\tStopping MySQL service\n\r"
        sudo service mysql stop
    fi
    echo "\tCopying configuration from '/vagrant/bootstrap/\n\r"
    sudo rm /etc/mysql/my.cnf
    sudo cp /vagrant/bootstrap/mysql/my.cnf /etc/mysql/my.cnf
    echo "\tRestarting server\n\r"
    sudo service mysql start
    echo "\tUpdating mysql root user to allow remote root login. - Do not Use in production\n\r"
    mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root';"
    mysql -uroot -proot -e "FLUSH PRIVILEGES;"
    echo "Configuration of MYSQL Server DONE\n\r\n\r"

    echo "Installing git\n\r"
    sudo apt-get install git -y > /dev/null
    echo "Installing cvs\n\r"
    sudo apt-get install subversion -y > /dev/null

    echo "Preparing to install PHP5 + Extras:\n\r"
    echo "  - apache2\n\r"
    echo "  - php5-mcrypt\n\r"
    echo "  - php5-xdebug\n\r"
    echo "  - php5-sqlite\n\r"
    echo "  - php5-curl\n\r"
    echo "  - php5-mysql\n\r"
    echo "  - sqlite3\n\r"
    sudo apt-get install -y php5 php5-mcrypt php5-sqlite php5-xdebug php5-curl php5-mysql sqlite3 -qq > /dev/null

    echo "\tVerifying composer is installed and up-to-date...\n\r"
    if [ ! -f /usr/local/bin/composer ]; then
        echo "\tDownloading composer in '/usr/local/bin/composer'.\n\r"
        sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer > /dev/null
        chmod +x /usr/local/bin/composer
    else
        sudo composer self-update > /dev/null
    fi

    echo "\tChanging directory to '/var/www'\n\r"
    cd /var/www
    if [ -f /vagrant/bootstrap/php/composer.sh ]; then
      echo "\tRunning user defined composer commands"
      chmod +x /vagrant/bootstrap/php/composer.sh && /vagrant/bootstrap/php/composer.sh < /dev/null && cd
    fi
    cd
    echo "Finished installing PHP5 components\n\r\n\r"

    echo "Downloading Development Tool binaries"
    cd /vagrant/bin


    if [ -f phing ]; then
      echo "\tUpdating Phing"
      rm phing
    else
      echo "\tDownloading Phing"
    fi
    wget http://www.phing.info/get/phing-latest.phar > /dev/null 2>&1
    mv phing-latest.phar phing && chmod +x phing

    if [ -f codecept ]; then
      echo "\tUpdating Codeception"
      rm codecept
    else
      echo "\tDownloading Codeception"
    fi
    wget http://codeception.com/codecept.phar > /dev/null 2>&1
    mv codecept.phar codecept && chmod +x codecept

    if [ -f phpunit ]; then
     echo "\tUpdating PHPUnit"
     rm phpunit
    else
      echo "\tDownloading PHPUnit"
    fi
    wget https://phar.phpunit.de/phpunit.phar > /dev/null 2>&1
    mv phpunit.phar phpunit && chmod +x phpunit

    if [ -f phpcs ]; then
      echo "\tUpdating PHP Code Sniffer"
      rm phpcs
    else
      echo "\tDownloading PHP Code Sniffer"
    fi
    curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar > /dev/null 2>&1
    mv phpcs.phar phpcs && chmod +x phpcs

    if [ -f phpcbf ]; then
      echo "\tUpdating PHP Code Beautifier and Fixer"
      rm phpcbf
    else
      echo "\tDownloading PHP Code Beautifier and Fixer"
    fi
    echo "\tDownloading PHP "
    curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar > /dev/null 2>&1
    mv phpcbf.phar phpcbf && chmod +x phpcbf


    if [ -f phpmd ]; then
      echo "\tUpdating PHP Mess Detector"
      rm phpmd
    else
      echo "\tDownloading PHP Mess Detector"
    fi
    wget http://static.phpmd.org/php/latest/phpmd.phar > /dev/null 2>&1
    mv phpmd.phar phpmd && chmod +x phpmd


    echo "Configuring Apache2\n\r"
    echo "\tStopping service\n\r"
    sudo service apache2 stop > /dev/null
    echo "\tCopying modified default apache vhost"
    sudo rm /etc/apache2/sites-available/000-default.conf
    sudo cp /vagrant/bootstrap/apache/000-default.conf /etc/apache2/sites-available/000-default.conf


    echo "\tCopying modified 'apache2.conf' to allow usage of .htaccess"
    sudo rm /etc/apache2/apache2.conf
    sudo cp /vagrant/bootstrap/apache/apache2.conf /etc/apache2/apache2.conf

    echo "\tCopying modified default ssl apache vhost\n\r"
    sudo rm /etc/apache2/sites-available/default-ssl.conf
    sudo cp /vagrant/bootstrap/apache/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

    echo "\tEnabling mod_rewrite\n\r"
    sudo a2enmod rewrite > /dev/null
    echo "\tEnabling mod_ssl\n\r"
    sudo a2enmod ssl > /dev/null
    echo "\tEnabling default SSL VHost\n\r"
    sudo a2ensite default-ssl > /dev/null
    echo "\tStarting Apache service\n\r"
    sudo service apache2 start > /dev/null


    if [ -d /var/www/html ]; then
        echo "Found default apache web root folder. Removing..."
        sudo rm -R /var/www/html
        echo "Done"
    fi
    echo "Done configuring Apache\n\r\n\r"

    echo "Checking if CA file is present\n\r"
    if [ ! -f /etc/ssl/certs/cacert.pem ]; then
        echo "Not found. Downloading.. 'http://curl.haxx.se/ca/cacert.pem'\n\r"
        cd /etc/ssl/certs && sudo wget http://curl.haxx.se/ca/cacert.pem > /dev/null 2>&1 && cd
    fi
    echo "Done\n\r\n\r"

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