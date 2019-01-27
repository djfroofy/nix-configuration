# nix-configuration
My nixos configuraiton.

Steps for setting up prior to nixos installation (assuming root user):

    rm -rf /etc/nixos
    cd /etc
    git clone git@github.com:djfroofy/nix-configuration.git nixos
    # create symlink to local configuration (drewripper is my setup for home desktop)
    ln -s local-configuration\#\#drewripper.nix local-configuration.nix 

