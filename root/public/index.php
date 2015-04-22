<?php
echo 'Hello, World!<br />';

echo 'I am working <br />';

$mem = new Memcached();
if (count($mem->getServerList()) <= 0) {
    $mem->addServer('localhost', 11211);
}

$mem->set('test', 'I am coming from the Cache');

echo 'Cache result: ' . print_r($mem->get('test'), true);

phpinfo();
