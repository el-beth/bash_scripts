#!/bin/bash

/usr/sbin/rfkill unblock all;
/etc/init.d/network-manager start;
/sbin/ifconfig enp2s0 up;
/sbin/ifconfig wlp3s0 up;
/sbin/ifconfig lo up;
/sbin/ifconfig docker0 up;
/usr/bin/notify-send -u critical -i /media/endrias/ntfs6/micky_migrations/ducky_payload_samples/favicon.ico "Done setting up BRIGHT" "All network interfaces are up";
