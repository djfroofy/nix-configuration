#!/run/current-system/sw/bin/bash

sudo -i nix-channel --add https://github.com/musnix/musnix/archive/master.tar.gz musnix
sudo -i nix-channel --update musnix
