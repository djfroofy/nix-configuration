# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{


  boot = {
    kernelParams = [
      "radeon.si_support=0"
      "radeon.cik_support=0"
      "amdgpu.si_support=1"
      "amdgpu.cik_support=1"
    ];

    kernelModules = [
       "snd-seq"
       "snd-rawmidi"
    ];

    loader = {
      grub = {
          enable = true;
          device = "nodev";
          version = 2;
          enableCryptodisk = true;
      };
    };
    
    initrd.luks.devices = [
        {
          name = "root";
          device = "/dev/disk/by-uuid/a1c7d532-adc5-4b80-83f3-d59bfef75315"; # UUID for /dev/nvme01np2 
          preLVM = true;
          allowDiscards = true;
        }
    ];
  };

  networking = {
    hostName = "drewripper";
    wireless = {
      enable = true;
    };
  };

  hardware = {
    enableAllFirmware = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
    opengl = {
      driSupport32Bit = true;
      enable = true;
    };
  };

  services.xserver = {
    useGlamor = true;
    deviceSection = ''
      Option "DRI" "3"
      Option "TearFree" "on"
      '';
    videoDrivers = [ "amdgpu" ];
  };

}
