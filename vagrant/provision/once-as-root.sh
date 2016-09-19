#!/usr/bin/env bash

#== Bash helpers ==

function info {
  echo " "
  echo "--> $1"
  echo " "
}


info "Provision-script user: `whoami`"

info "Configure Apache"
a2enmod rewrite
sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=vagrant/g' /etc/apache2/envvars
sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=vagrant/g' /etc/apache2/envvars

info "Enabling site configuration"
ln -s /apps/vagrant/apache/apps.conf /etc/apache2/sites-enabled/apps.conf

info "Install Composer Vendor"
composer config -g repo.packagist composer https://packagist.phpcomposer.com
composer config -g github-oauth.github.com 4b9576f0957903fa12044b7fb1bedf3b73fecdfc
composer global require "fxp/composer-asset-plugin:~1.1.1"
cd /apps && composer install -vvv --prefer-dist

echo "Done!"