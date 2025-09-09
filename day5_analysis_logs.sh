#!/bin/bash
LOG_FILE="/var/log/httpd/access_log"

# Analizar las direcciones IP más frecuentes
echo "Direcciones IP más frecuentes:"
awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -rn | head -10

# Analizar los códigos de estado más comunes
echo "Códigos de estado más comunes:"
awk '{print $9}' $LOG_FILE | sort | uniq -c | sort -rn | head -10

# Analizar las URL más solicitadas
echo "URL más solicitadas:"
awk '{print $7}' $LOG_FILE | sort | uniq -c | sort -rn | head -10
