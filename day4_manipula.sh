#!/bin/bash
# Definir el archivo de entrada
ARCHIVO="datos.txt"
# Mostrar el contenido del archivo
echo "Contenido del archivo:"

cat "$ARCHIVO"
# Buscar líneas que contengan la palabra "error"
echo "Líneas que contienen la palabra 'error':"
grep "error" "$ARCHIVO"
# Reemplazar la palabra "error" con "ERROR"
echo "Reemplazar 'error' con 'ERROR':"
sed 's/error/ERROR/g' "$ARCHIVO"
# Extraer la primera columna del archivo
echo "Primera columna del archivo:"
awk '{print $1}' "$ARCHIVO"
# Contar el número de líneas que contienen la palabra "warning"
echo "Número de líneas que contienen la palabra 'warning':"
grep -c "warning" "$ARCHIVO"

# Mostrar las líneas que no contienen la palabra "info"
echo "Líneas que no contienen la palabra 'info':"
grep -v "info" "$ARCHIVO"
