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
echo $loop_device > $TEMP_FILE
echo "Loop Device: $(cat $TEMP_FILE)"
}

format_loop(){
LD=$(cat $TEMP_FILE)
mkfs.xfs $LD
mkdir -pv $MOUNTPATH
echo "$LD $MOUNTPATH xfs defaults 0 0" >> /etc/fstab
mount $MOUNTPATH
echo "Dispositivo loop creado y montado en $MOUNTPATH"
}

# MAIN

TEMP_FILE=mktemp

SIZE=$(echo $1)
MOUNTPATH=$(echo $2)
loop_device=""

validar_loop
crear_loop
format_loop
