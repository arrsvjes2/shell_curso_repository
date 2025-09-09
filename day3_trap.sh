#!/bin/bash
set -euo pipefail
trap 'echo "Error en la línea $LINENO"; rm $TEMP; exit 1' ERR
TEMP=$(mktemp)
echo $TEMP
# Comando que podría fallar
uptime
echo "Este mensaje no se mostrará si comando_inexistente falla"

# limpieza
rm $TEMP
