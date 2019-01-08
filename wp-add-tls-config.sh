#!/bin/sh

cd /home/node/website

awk "{ print} /table_prefix/ { print \"define('FORCE_SSL_ADMIN', true);if ( array_key_exists('HTTP_X_FORWARDED_PROTO',\$_SERVER) && strpos(\$_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false) \$_SERVER['HTTPS']='on';\" }" < wp-config.php > wp-config.php.temp; 

mv wp-config.php.temp wp-config.php



