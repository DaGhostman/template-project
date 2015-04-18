APACHE=$(type apache2 >/dev/null 2>&1 && echo 1 || echo 0)
if [ "$APACHE" == 1 ]; then
    if diff /vagrant/bootstrap/apache/000-default.conf /etc/apache2/sites-available/000-default.conf >/dev/null ; then
      echo "000-default.conf up-to-date"
    else
      echo "Stoping Apache2 Service"
      sudo service apache2 stop
      sudo rm /etc/apache2/sites-available/000-default.conf
      sudo cp /vagrant/bootstrap/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
      echo "Restarting service"
      sudo service apache2 start
    fi

    if diff /vagrant/bootstrap/apache/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf >/dev/null ; then
      echo "default-ssl.conf up-to-date"
    else
      echo "Preparing to copy default-ssl.conf"
      echo "Stoping Apache2 Service"
      sudo service apache2 stop
      sudo rm /etc/apache2/sites-available/default-ssl.conf
      sudo cp /vagrant/bootstrap/apache/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
      echo "Restarting service"
      sudo service apache2 start
    fi


    if diff /vagrant/bootstrap/apache/000-default.conf /etc/apache2/sites-available/000-default.conf >/dev/null ; then
      echo "Apache2 up-to-date"
    else
      echo "Stoping Apache2 Service"
      sudo service apache2 stop
      sudo rm /etc/apache2/apache2.conf
      sudo cp /vagrant/bootstrap/apache/apache2.conf /etc/apache2/apache2.conf
      echo "Restarting service"
      sudo service apache2 start
    fi


    echo "\tEnabling mod_rewrite\n\r"
    sudo a2enmod rewrite > /dev/null
    echo "\tEnabling mod_ssl\n\r"
    sudo a2enmod ssl > /dev/null
    echo "\tEnabling default SSL VHost\n\r"
    sudo a2ensite default-ssl > /dev/null
    echo "\tStarting Apache service\n\r"
    sudo service apache2 restart > /dev/null


    if [ -d /var/www/html ]; then
        echo "Found default apache web root folder. Removing..."
        sudo rm -R /var/www/html
        echo "Done"
    fi

    echo "Checking if CA file is present\n\r"
    if [ ! -f /etc/ssl/certs/cacert.pem ]; then
        echo "Not found. Downloading.. 'http://curl.haxx.se/ca/cacert.pem'\n\r"
        cd /etc/ssl/certs && sudo wget http://curl.haxx.se/ca/cacert.pem > /dev/null 2>&1 && cd
    fi
else
    echo "It seems that apache is not installed, please try again"
fi