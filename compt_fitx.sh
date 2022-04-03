#!/bin/bash
clear
echo "comptfitx.sh"
echo "Introdueix el directori d'origen: "
read dir1
tar -cvf Dir.tar $dir1
echo "Introdueix el directori d'arribada: "
read dir2
cp -rf Dir.tar $dir2
