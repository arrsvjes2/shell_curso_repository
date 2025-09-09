#!/bin/bash


#Input
echo "Ingresar primer numero:"
read num1

echo "Ingresas segundo numero"
read num2

# logical
if [ $num1 -eq $num2 ]; then
  echo "num1 $num1 es igual a num2 $num2"
elif [ $num1 -gt $num2 ]; then
  echo "num1 $num1 es mayor"
  echo "num2 $num2 es menor"
else 
  echo "num2 $num2 es mayor"
  echo "num1 $num1 es menor"
fi

 exit 0
