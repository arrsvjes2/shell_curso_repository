#!/bin/bash
# Definir el archivo de entrada
ARCHIVO="matricula.txt"
# Extraer números de teléfono
echo "Números de teléfono:"
grep -oE '\b[0-9]{3}-[0-9]{3}-[0-9]{4}\b' "$ARCHIVO"
# Extraer direcciones de correo electrónico
echo "Direcciones de correo electrónico:"
grep -oE '\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b' "$ARCHIVO"
# Extraer fechas
echo "Fechas:"
grep -oE '[0-9]{2}/[0-9]{2}/[0-9]{4}' "$ARCHIVO"
# Extraer números de cuenta
echo "Números de cuenta:"
grep -oE '[0-9]{10}' "$ARCHIVO"
