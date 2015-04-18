MYSQL=$(type mysql >/dev/null 2>&1 && echo 1 || echo 0)
if [ "$MYSQL" != 1 ]; then
    echo "Prepring to install MySQL Server 5.5"
    debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
    sudo apt-get install mysql-server-5.5 -y > /dev/null
    echo "Package installed successfully\n\r"
    echo "Waiting 10s for the service to start and continue with the configuration."
    sleep 10

    echo "Stoping MySQL service.."
    sudo service mysql stop

    echo "Copying bootstraped configuration"
    sudo rm /etc/mysql/my.cnf
    sudo cp /vagrant/bootstrap/mysql/my.cnf /etc/mysql/my.cnf
    echo "Starting server"
    sudo service mysql start

    echo "Setting up remote access, for root user"
    mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root';"
    mysql -uroot -proot -e "FLUSH PRIVILEGES;"
else
    echo "MySQL already installed and should be configured. Skiping"
fi