#!/bin/bash

sumar(){
res=$((num1+num2))
echo  "Resultado de la suma: $res"
}

echo "Bienvenido"
num1=45
num2=67
sumar
echo "Success"
exit 0
