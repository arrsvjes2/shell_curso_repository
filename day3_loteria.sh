#!/bin/bash

# Loteria
# Author: Jesus Arriola
# Fecha de mod: 
# Descripcion:


# VARS


# CONST


echo "Ingrese un numero entre 1-20"
read NUM

# Logica
if [ $NUM -eq 8 ]; then
  echo "Premio Gordo"
elif [ $NUM -eq 3 ]; then
  echo "Segundo premio"
else
  echo "Sigue jugando"
fi


# END
exit 0
