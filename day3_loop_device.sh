#!/bin/bash


validar_loop(){
# Verificar si se proporcionó el tamaño del dispositivo

if [ -z $SIZE ]; then
  echo "Error: Debe proporcionar el tamaño del dispositivo en MB"
  return 1
fi
# Verificar si se proporcionó el punto de montaje
if [ -z $MOUNTPATH ]; then
  echo "Error: Debe proporcionar el punto de montaje"
  return 1
fi

}

crear_loop(){
dd if=/dev/zero of=/tmp/dispositivo_loop.img bs=1M count=$SIZE
losetup -f /tmp/dispositivo_loop.img
loop_device=$(losetup -j /tmp/dispositivo_loop.img | cut -d ':' -f 1)
echo "Loop Device: $loop_device"
}

# MAIN

SIZE=$(echo $1)
MOUNTPATH=$(echo $2)

validar_loop
crear_loop
