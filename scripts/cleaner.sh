#!/bin/sh
#
# garbage collection, remove old generations and keep just the current
sudo nix-collect-garbage -d | nix-collect-garbage -d |
    sudo rm /run/booted-system | sudo nix-collect-garbage

