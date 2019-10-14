# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{

  users.users.root.openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAAa......feedbeefpizza toshiro@example.com"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.toshiro = {
    shell = pkgs.zsh;
    isNormalUser = true;
    home = "/home/toshiro";
    description = "Toshiro Yamashita";
    extraGroups = [ "audio" "wheel" "networkmanager" "docker" "dialout"];
    hashedPassword = "$4$5$6deaffeed$7$8";
    openssh.authorizedKeys.keys = [
      "ssh-rsa BBBBBb......foodstufftaxe guest@example.com"
      "ssh-rsa AAAAAa......feedbeefpizza toshiro@example.com"
  ];

  };
  users.users.guest = {
    shell = pkgs.zsh;
    isNormalUser = true;
    home = "/home/guest";
    extraGroups = [ "audio" "networkmanager" "docker"];
  };

   
}
