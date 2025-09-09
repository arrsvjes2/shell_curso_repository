#!/bin/bash

# Nombre:
# Author:
# FEcha  ult cam
# Descrpcion

if [ ! $# -eq 3 ]; then
 echo "Usage: day1_vars.sh arg1 arg2 serverremote"
 exit 1
fi

rm -f script-remote.sh

echo "#!/bin/bash" > script-remote.sh
echo "nombre=firox" >> script-remote.sh
echo "nombres=Juan,Pedro,Manolo,Paco" >> script-remote.sh
echo "edad=80" >> script-remote.sh
echo "PI=3.14" >> script-remote.sh
echo "ruta=\$(pwd)" >> script-remote.sh
echo "primerArgumento=$1" >> script-remote.sh
echo "segundoArgumento=$2"  >> script-remote.sh
echo "shell=\$(echo \$SHELL)" >> script-remote.sh
SERVER=$3
ssh root@$SERVER rm -f ./script-remote.sh


echo "Ejecutar las variables en el SERVER: $SERVER"

echo "echo \$nombre" >> script-remote.sh
echo "echo \$nombres" >> script-remote.sh
echo "echo \$edad" >> script-remote.sh
echo "echo \$PI" >> script-remote.sh
echo "echo \$primerArgumento"  >> script-remote.sh
echo "echo \$segundoArgumento" >> script-remote.sh 
echo "echo \$shell" >> script-remote.sh

chmod -v a+x script-remote.sh
scp script-remote.sh root@$SERVER:/root
ssh root@$SERVER ./script-remote.sh

# CLEANUP
rm -f script-remote.sh
ssh root@$SERVER rm -f ./script-remote.sh

exit 0
