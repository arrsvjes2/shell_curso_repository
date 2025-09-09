#!/bin/bash

# Configuración
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASSWORD="wordpress"
WP_VERSION="latest"

# Instalación de dependencias
echo "Instalando dependencias..."
sudo dnf install -y httpd mariadb-server php php-mysqlnd

# Configuración de la base de datos
echo "Configurando la base de datos..."
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql -e "CREATE DATABASE $DB_NAME;"
sudo mysql -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Descarga y configuración de WordPress
echo "Descargando y configurando WordPress..."
sudo wget https://wordpress.org/$WP_VERSION.tar.gz -P /tmp/
sudo tar -xvf /tmp/$WP_VERSION.tar.gz -C /var/www/html/
sudo mv /var/www/html/wordpress /var/www/html/myblog
sudo chown -R apache:apache /var/www/html/myblog
sudo chmod -R 755 /var/www/html/myblog

# Configuración de Apache
echo "Configurando Apache..."
sudo tee /etc/httpd/conf.d/myblog.conf <<EOF
<VirtualHost *:80>
    ServerName myblog.local
    DocumentRoot /var/www/html/myblog
    <Directory /var/www/html/myblog>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
sudo systemctl restart httpd
sudo systemctl enable httpd

# Configuración de WordPress
echo "Configurando WordPress..."
sudo tee /var/www/html/myblog/wp-config.php <<EOF
<?php
define('DB_NAME', '$DB_NAME');
define('DB_USER', '$DB_USER');
define('DB_PASSWORD', '$DB_PASSWORD');
define('DB_HOST', 'localhost');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
define('AUTH
