#!/bin/sh

cd /home/node/website

awk "{ print} /table_prefix/ { print \"define('DISABLE_WP_CRON', true);\" }" < wp-config.php > wp-config.php.temp; 

mv wp-config.php.temp wp-config.php



