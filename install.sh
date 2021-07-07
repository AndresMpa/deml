#!/bin/bash

echo "
 __        __   _                       _          ____  _____ ____  _
 7 7      V V__| | ___ ___  _ __ ___   | |_ ___   |  _ 7| ____/ ___|| |
  7 7 V7 V V _ 7 |/ __/ _ 7| |_ 7 _ 7  | __V _ 7  | | | |  _| 7___ 7| |
   7 V  V V  __/ | (_| (_) | | | | | | | || (_) | | |_| | |___ ___) | |___
    7_V7_V 7___|_|7___7___/|_| |_| |_|  7__7___/  |____/|_____|____/|_____|

    Developer Environmet Setter for Linux

This is a helper to set environments for unix users (This may work also for MAC)

Choose an environment

1) Ubuntu (ES)
2) Ubuntu (EN)
3) Arch Linux

Choose an environment: 
"

read -p 'Environmet: ' environment

echo "$environment"

if [[ "$environment" == "1" ]];
then
	echo "Ubuntu (ES)"
	exec ./environment/ubuntu_es.sh
elif [[ "$environment" == "2" ]];
then
	echo "Ubuntu (EN)"
	exec ./environment/ubuntu_en.sh
elif [[ "$environment" == "3" ]];
then
	echo "Arch Linux"
	exec ./environment/arch_linux.sh
else
	echo "Error"
fi
