#!/bin/bash

/usr/sbin/rfkill block all;
/etc/init.d/network-manager stop;
/sbin/ifconfig enp2s0 down;
/sbin/ifconfig wlp3s0 down;
/sbin/ifconfig lo down;
/sbin/ifconfig docker0 down;
/usr/bin/notify-send -u critical -i /media/endrias/ntfs6/micky_migrations/ducky_payload_samples/favicon.ico "Done setting up DARK" "All network interfaces are down";

