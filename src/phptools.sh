# Uncomment then then section for then tool you are looking to use

cd /vagrant/bin

### BEGIN PHING
# if [ -f phing ]; then
#     echo "\tUpdating Phing"
#     rm phing
# else
#     echo "\tDownloading Phing"
# fi
# wget http://www.phing.info/get/phing-latest.phar > /dev/null 2>&1
# mv phing-latest.phar phing && chmod +x phing
### END PHING

### BEGIN CODECEPTION
# if [ -f codecept ]; then
#   echo "\tUpdating Codeception"
#   rm codecept
# else
#   echo "\tDownloading Codeception"
# fi
# wget http://codeception.com/codecept.phar > /dev/null 2>&1
# mv codecept.phar codecept && chmod +x codecept
### END CODECEPTION

### BEGIN PHPUnit
# if [ -f phpunit ]; then
#   echo "\tUpdating PHPUnit"
#   rm phpunit
# else
#   echo "\tDownloading PHPUnit"
# fi
# wget https://phar.phpunit.de/phpunit.phar > /dev/null 2>&1
# mv phpunit.phar phpunit && chmod +x phpunit
### END PHPUnit

### BEGIN PHP Code Sniffer
# if [ -f phpcs ]; then
#   echo "\tUpdating PHP Code Sniffer"
#   rm phpcs
# else
#   echo "\tDownloading PHP Code Sniffer"
# fi
# curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar > /dev/null 2>&1
# mv phpcs.phar phpcs && chmod +x phpcs
### END PHP Code Sniffer


### BEGIN PHP Code Beautifier and Fixer
# if [ -f phpcbf ]; then
#   echo "\tUpdating PHP Code Beautifier and Fixer"
#   rm phpcbf
# else
#   echo "\tDownloading PHP Code Beautifier and Fixer"
# fi
#
# curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar > /dev/null 2>&1
# mv phpcbf.phar phpcbf && chmod +x phpcbf
### END PHP Code Beautifier and Fixer


### BEGIN PHP Mess Detector
# if [ -f phpmd ]; then
#   echo "\tUpdating PHP Mess Detector"
#   rm phpmd
# else
#   echo "\tDownloading PHP Mess Detector"
# fi
# wget http://static.phpmd.org/php/latest/phpmd.phar > /dev/null 2>&1
# mv phpmd.phar phpmd && chmod +x phpmd
### END PHP Mess Detector


cd