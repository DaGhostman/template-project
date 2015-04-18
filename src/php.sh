PHP=$(type php > /dev/null 2>&1 && echo 1 || echo 0)
if [ "$PHP" != 1 ]; then
echo "Preparing to install PHP5 + Apache2"
sudo apt-get install -y php5 > /dev/null 2>&1
echo "Installing xdebug extension"
sudo apt-get install php5-xdebug -y > /dev/null 2>&1
echo "Installing curl extension"
sudo apt-get install php5-curl -y > /dev/null 2>&1
echo "Installing sqlite extension"
sudo apt-get install php5-sqlite sqlite3 -y > /dev/null 2>&1
echo "Installing mysql extension"
sudo apt-get install php5-mysql -y > /dev/null 2>&1
echo "Installing mcrypt extension"
sudo apt-get install php5-mcrypt -y > /dev/null 2>&1
else
    echo "PHP already installed. Skiping"
fi

echo "\tVerifying composer is installed and up-to-date...\n\r"
if [ ! -f /usr/local/bin/composer ]; then
    echo "\tDownloading composer in '/usr/local/bin/composer'.\n\r"
    sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer > /dev/null 2>&1
    chmod +x /usr/local/bin/composer
else
    sudo composer self-update > /dev/null 2>&1
fi

echo "Updating composer dependencies..."
cd /var/www && composer update && cd