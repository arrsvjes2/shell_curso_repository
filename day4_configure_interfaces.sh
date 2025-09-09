#!/bin/bash


# buscar que existan dos interfaces de red dummy.
# En caso de que no existan, mensaje de error y un exit1

MTU_VALUE=9000

COUNT_DUMMY=$(ip a s | grep mtu | grep -e "dummy0" -e "dummy1" | wc -l)

if [ $COUNT_DUMMY -lt 2 ]; then
  echo "No estan presentes las interfaces de red requeridas"
  exit 1
fi

nmcli con s | grep con-dummy0
# la conexion no existe codigo de retorno 1 
if [ $? -eq 0 ]; then
  echo "La conexion con-dummy0 ya existe"
  exit 1
fi

nmcli con s | grep con-dummy1
if [ $? -eq 0 ]; then
  echo "La conexion con-dummy1 ya existe"
  exit 1
fi


# Configurar el MTU 9000
ip link set dummy0 mtu $MTU_VALUE
ip link set dummy1 mtu $MTU_VALUE

nmcli con add type dummy con-name con-dummy0 ifname dummy0 ipv4.address 192.168.10.1/24 ipv4.method manual 
nmcli con add type dummy con-name con-dummy1 ifname dummy1 ipv4.address 192.168.20.1/24 ipv4.method manual 
nmcli con up con-dummy0
nmcli con up con-dummy1
