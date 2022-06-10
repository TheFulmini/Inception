#!/bin/bash

if [[ $OSTYPE == 'darwin'* ]]; then

    # on MacOS

    mkdir -p ./volumes/wp_volume
    mkdir -p ./volumes/db_volume

    exit
fi

# on Linux

 sudo -S mkdir -p ${HOME}/data/db
 sudo -S mkdir -p ${HOME}/data/wp
 # sudo -S mkdir -p ${HOME}/data/db_volume
 # sudo -S mkdir -p ${HOME}/data/wp_volume

 sudo -S chmod 777 /etc/hosts
 sudo -S hostnamectl set-hostname ${USER}.42.fr
 sudo -S sed -i 's/salty-VirtualBox/afulmini.42.fr/g' /etc/hosts
 sudo -S sed -i '3i 127.0.0.1    afulmini.42.fr/g' /etc/hosts
 sudo -S sed -i '1 i\127.0.0.1	afulmini.42.fr' /etc/hosts
 sudo -S chmod 0444 /etc/hosts

 sudo -S service nginx stop
 sudo -S systemctl start docker
 sudo -S hostnamectl 