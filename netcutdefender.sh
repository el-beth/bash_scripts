#!/bin/bash

service network-manager stop
macchanger -r enp2s0
macchanger -r wlp3s0
service network-manager start

