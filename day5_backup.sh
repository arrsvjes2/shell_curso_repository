#!/bin/bash

SOURCE_DIR=/etc
DEST_DIR=/backup
LOG_FILE=/var/log/backups.log

# Crear el directorio de destino si no existe
# Almancenamiento centralizado por ejemplo NFS
mkdir -p $DEST_DIR

# Realizar el respaldo
rsync -avz $SOURCE_DIR/ $DEST_DIR/

# Registrar el resultado en el log
echo "$(date +%s) Respaldo realizado con éxito" >> $LOG_FILE
