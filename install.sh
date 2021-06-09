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

1) Ubuntu (ES):

Choose an environment: 
"
environment=1
read $environment

if [ $environment == 1 ];
then
	exec ./environment/ubuntu.sh
fi
