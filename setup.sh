#!/run/current-system/sw/bin/bash

nix-channel --add https://github.com/musnix/musnix/archive/master.tar.gz musnix
nix-channel --update musnix
