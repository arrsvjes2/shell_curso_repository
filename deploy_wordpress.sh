#!/bin/bash

# Configuración
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASSWORD="wordpress"
WP_VERSION="latest"

# Validar el numero de CPUs disponibles
DESIRED_CPUS=2
NUMPROC=$(nproc)
DESIRED_MEMORY=4096

if [ $NUMPROC -lt $DESIRED_CPUS ]; then
  echo "Requerimiento de CPUS no superado (2) "
  exit 1
fi

# Validar la existencia de 4096MB
MEM_AVAILABLE=$(free -m | grep Mem | awk '{ print $2}')

if [ $MEM_AVAILABLE -lt $DESIRED_MEMORY ]; then
  echo "Requerimiento de RAM no superado (4096M)"
  exit 1
fi

exit 0 


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
define('AUTH_KEY',         'put your unique phrase here');
define('SECURE_AUTH_KEY',  'put your unique phrase here');
define('LOGGED_IN_KEY',    'put your unique phrase here');
define('NONCE_KEY',        'put your unique phrase here');
define('AUTH_SALT',        'put your unique phrase here');
define('SECURE_AUTH_SALT', 'put your unique phrase here');
define('LOGGED_IN_SALT',   'put your unique phrase here');
define('NONCE_SALT',       'put your unique phrase here');
\$table_prefix  = 'wp_';
\$wp_local_package = 'es_ES';
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');
require_once(ABSPATH . 'wp-settings.php');
EOF

echo "WordPress instalado y configurado correctamente."
