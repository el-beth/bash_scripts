#!/bin/bash

sudo service network-manager stop
sudo rm /etc/NetworkManager/system-connections/"$1"
sudo service network-manager start
