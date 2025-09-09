#!/bin/bash

dir=~/movies
pattern="*.txt"

list_files=$(find $dir -type f -name "$pattern")

for ARCH in $list_files
do
  echo $ARCH
  wc -l $ARCH
done
