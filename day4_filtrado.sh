#!/bin/bash
# Definir el archivo de entrada
ARCHIVO="texto.txt"
# Mostrar el contenido del archivo
echo "Contenido del archivo:"
cat "$ARCHIVO"
# Buscar líneas que contengan la palabra "error"
echo "Líneas que contienen la palabra 'error':"
grep "error" "$ARCHIVO"
# Buscar líneas que no contengan la palabra "info"
echo "Líneas que no contienen la palabra 'info':"
grep -v "info" "$ARCHIVO"
# Buscar líneas que comiencen con la palabra " warning"
echo "Líneas que comienzan con la palabra 'warning':"
grep "^warning" "$ARCHIVO"
# Buscar líneas que terminen con la palabra "fin"
echo "Líneas que terminan con la palabra 'fin':"
grep "fin$" "$ARCHIVO"
# Contar el número de líneas que contienen la palabra "error"
echo "Número de líneas que contienen la palabra 'error':"
grep -c "error" "$ARCHIVO"
# Mostrar las líneas que contienen la palabra "error" ignorando mayúsculas y minúsculas
echo "Líneas que contienen la palabra 'error' (ignorando mayúsculas y minúsculas):"
grep -i "error" "$ARCHIVO"
