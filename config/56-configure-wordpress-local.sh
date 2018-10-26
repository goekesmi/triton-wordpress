#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

ADMIN_USER='msumatrix'
ADMIN_EMAIL='matrix@msu.edu'
ADMIN_PW=`uuid`
SITEURL=`mdata-get siteurl`


mdata-put wordpress-pw $ADMIN_PW

cd /home/node/website;
su - node -c "wp core install --url="$SITEURL" --title='MATRIX TEMPORARY' --admin_user=$ADMIN_USER --admin_password=$ADMIN_PW --admin_email=$ADMIN_EMAIL --path=/home/node/website"

awk "{ print} /table_prefix/ { print \"define('FORCE_SSL_ADMIN', true);if ( array_key_exists('HTTP_X_FORWARDED_PROTO',\$_SERVER) && strpos(\$_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false) \$_SERVER['HTTPS']='on';\" }" < wp-config.php > wp-config.php.temp; 

mv wp-config.php.temp wp-config.php

chown node:www wp-config.php

chown -R node:www *
 
su - node -c "wp theme activate ruby-theme --path=/home/node/website"
su - node -c "wp plugin install /home/node/wp-accessibility.1.6.4.zip --path=/home/node/website"

