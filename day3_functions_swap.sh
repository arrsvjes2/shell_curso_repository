#!/bin/bash

crear_dispositivo_swap() {
# Verificar si se proporcionó el tamaño del dispositivo
if [ -z $SIZE ]; then
  echo "Error: Debe proporcionar el tamaño del dispositivo en MB"
  return 1
fi
# Verificar si se proporcionó la prioridad
if [ -z $PRIORITY ]; then
  echo "Error: Debe proporcionar la prioridad"
  return 1
fi

# Crear el dispositivo loop
dd if=/dev/zero of=/tmp/dispositivo_swap.img bs=1M count=$SIZE
losetup -f /tmp/dispositivo_swap.img
loop_device=$(losetup -j /tmp/dispositivo_swap.img | cut -d ':' -f 1)

# Formatear el dispositivo con swap
mkswap $loop_device

# Agregar la entrada al /etc/fstab
echo "$loop_device none swap sw,pri=$PRIORITY 0 0" >> /etc/fstab

# Activar el swap
swapon -a
echo "Dispositivo swap creado y activado con prioridad $PRIORITY"
}
