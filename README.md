# nix-configuration

My /etc/nixos configuration files.

Steps for setting up prior to nixos installation (assuming root user).

## Clone nix-configuration to /etc/nixos

    cd /etc
    # backup existing nixos
    [[ -d nixos ]] && mv nixos nixos.bak
    # clone this project
    git clone git@github.com:djfroofy/nix-configuration.git nixos

## Create local-configuration.nix symlink

Choose or create a local configuration file that works best for your current machine:

    # create symlink to local configuration (drewripper is my setup for home desktop)
    ln -s local-configuration\#\#drewripper.nix local-configuration.nix 

## Copy users-example and update

    cp users-example.nix users.nix
    # edit to your preferred users
    $EDITOR users.nix

