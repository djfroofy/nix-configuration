# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dsmather = {
    shell = pkgs.zsh;
    isNormalUser = true;
    home = "/home/dsmather";
    description = "Drew Smathers";
    extraGroups = [ "audio" "wheel" "networkmanager" "docker"];
    hashedPassword = "$6$V3zegIOS$cT/cGGtH9c5mMq3LSUo.FQ7JfsRRr9QFsV.ox0J1VN9R1/GXk.pPQAIce.WJMXvYZuO0ycNBmIHzgUSiul5a/1";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDG1w8RG7zAv0zxBBfwq4xJu1JH7yCYvG8SAZTfoBLmRUvAUWtlvulxaG7xW9B+gsrCKG+4c2GgN2Q1+nT08qHlceD/2zCG5tTiZ/h0BYv3nQg7D2aJ+hRBHZI1taRgImo7V/iZNIS7KOxSL+QZOl23Id4T1I64I/32qkJT6viG6GSagQ3EZVb9yzZQoATV/WZjB7VylFp7hpwlvwBeSLYotgvhgEWPizj1a06v0+WsczvENx2evZFRjrNEejCED4N5F6G1RPMced1Wxo5SOKKhZA60aw6gGl+p6fTvDQTkwefjVdnS9YMghNSpvRfJQfha/LinQEWIHlpg2lW8HBKr dsmather@dsmather-mac"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDj78jSe33zPiThCv64GuCtP/Tn7BfOzX+kDlfbEIJABFs1Bgcl7enxCw70kUyc49xg+l8gv0Yj0Jr/Ftpr8nx3A7o2jMOL44CYJvH6gXER1bJbeg+QXBHnv654AXbTy8tjZCgkhk3nlngHEKzInzg0AjjZ9Lt3G9bfQKstADGAfTtuHQ+0jq/Lb+1pcxEOek0MGZ4GhfByN//3PqeEjMmV+a/w/iuqkQmoOeZvhhsVc/4GBKd1Gnw10QIRJw7su0+FkVfpB9Z1i78QsaFU7pBYojGjagieJMyUTZoNsGrHnjGtXopVECGkut36BbybuYzt8VkGuaWj99xw5rb19EKz dsmather@drewripper"
  ];

  };
  users.users.nzs = {
    shell = pkgs.zsh;
    isNormalUser = true;
    home = "/home/nzs";
    extraGroups = [ "audio" "wheel" "networkmanager" "docker"];
  };
  users.users.mzs = {
    shell = pkgs.zsh;
    isNormalUser = true;
    home = "/home/mzs";
    extraGroups = [ "wheel" "networkmanager" "docker"];
  };

   
}
