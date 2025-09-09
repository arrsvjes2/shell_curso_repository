#!/bin/bash
# Configuración del servicio
SERVICE_NAME="httpd"
SERVICE_PORT=80

# Configuración del correo electrónico
EMAIL_TO="root@localhost"
EMAIL_SUBJECT="Servicio $SERVICE_NAME no está funcionando"

# Verificar si el servicio está funcionando
if ! nc -z localhost $SERVICE_PORT &> /dev/null; then
  DATA=$(ps -aux)
  # Enviar un correo electrónico si el servicio no está funcionando
  printf "El servicio %s no esta funcionando\n\n%s" "$SERVICE_NAME" "$DATA" | mail -s "$EMAIL_SUBJECT" $EMAIL_TO
fi
