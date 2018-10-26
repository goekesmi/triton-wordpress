#!/bin/env bash

cd $HOME/website/

date

wp core update --skip-plugins --skip-themes
wp plugin update --skip-plugins --skip-themes --all 
wp theme  update --skip-plugins --skip-themes --all 
find . -type d -print0 | xargs -0 chmod 2755 
find . -type f -print0 | xargs -0 chmod 755 
find ./wp-content/uploads  -print0 | xargs -0 chmod g+w 
