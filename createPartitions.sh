#!/bin/bash
diskGB="$3"
sliceGB=1000
partsize=$(($sliceGB*1000*1000*1000/1024/1024 - 1))

for ((i=1; i <= $(($diskGB/$sliceGB)); i++))
do
    sudo parted -a optimal -- "$1" mkpart md"$i"-"$2" $(($i+($i-1)*$partsize))MiB $(($i+$i*$partsize))MiB
    echo "sudo parted -a optimal -- "$1" mkpart md"$i"-"$2" $(($i+($i-1)*$partsize))MiB $(($i+$i*$partsize))MiB"
done
sudo parted "$1" print free
