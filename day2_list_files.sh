#!/bin/bash

dir=/tmp

LISTFILES=$(find $dir -type d 2>/dev/null)

for ARCH in $LISTFILES
do
  echo $ARCH
done
