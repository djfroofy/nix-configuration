{ config, pkgs, ... }:

{
  # There is no desktop manager :) just a simple and keyboard-friendly window manager: xmonad
  services.xserver = {
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
          haskellPackages.xmobar
          haskellPackages.xmonad-wallpaper
        ];
      };
      # remove this line at when migrating from 19.09 to 20.03
      # default = "xmonad";
    };
    # uncomment the following line when migrating from 19.09 to 20.03
    displayManager.defaultSession = "none+xmonad";
  };
}
