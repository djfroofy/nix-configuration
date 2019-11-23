#!/usr/bin/env bash

set -euf -o pipefail

for dropin in work personal
do
        if [[ -d "${dropin}" ]]
        then
                echo Drop-in ${dropin} already exists, skipping
        else
                mkdir -p ${dropin}
                echo "{ ... }: {}" > ${dropin}/home.nix
                echo "{ ... }: {}" > ${dropin}/configuration.nix
                echo "pkgs: with pkgs; []" > ${dropin}/packages.nix
                echo "================================================================"
                echo "Created stub directory for your ${dropin} configurations. At a later point"
                echo "you can backup and symlink in prefered ${dropin} configurations. Ex:"
                echo "    cd ~/.config/nixpgs"
                echo "    mv ${dropin} ${dropin}.bak"
                echo "    ln -s ~/Projects/nix-home-${dropin} ${dropin}"
                echo "================================================================"
        fi
done

sudo nix-channel --add https://github.com/musnix/musnix/archive/master.tar.gz musnix
sudo nix-channel --update musnix
