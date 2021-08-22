#!/bin/bash
# test by wanging up a lamp stack

sudo yum -y install httpd mariadb php phpmysqlnd
sudo systemctl enable --now httpd
sudo firewall-cmd --add-service=http --add-service=https
sudo firewall-cmd --add-service=http --add-service=https --permanent
sudo systemctl enable --now mariadb
sudo echo "<?php phpinfo(); ?>" > /var/www/html/index.php
sudo systemctl restart httpd