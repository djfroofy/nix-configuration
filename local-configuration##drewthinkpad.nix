# This is local configuration for my ThinkPad T490

{ config, pkgs, ...}:
{ 
  
  boot = {
    kernelParams = [ "intel_pstate=no_hwp" ];
    kernelPackages = pkgs.linuxPackages_latest;

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
          efiSupport = true;
          gfxmodeEfi = "1024x780";
      };
      efi.canTouchEfiVariables = true;
    };
    
    initrd.luks.devices = [
        {
          name = "root";
          device = "/dev/disk/by-uuid/69f61735-98e3-46ce-ab9a-b28573708481";
          preLVM = true;
          allowDiscards = true;
        }
    ];
    plymouth = {
      enable = true;
    };
  };

  networking = {
    hostName = "drewthinkpad";
    wireless = {
      enable = true;
    };
    #interfaces.wlp5s0 = {
    #  ipv4.addresses = [ {
    #    address = "192.168.1.16";
    #    prefixLength = 24;
    #  }];
    #  mtu = 2300;
    #};
    #defaultGateway = "192.168.1.1";
    #nameservers = [ "8.8.8.8" ];
    dhcpcd.enable = true;
  };

  hardware = {
    enableAllFirmware = true;
    #pulseaudio = {
    #  enable = true;
    #  package = pkgs.pulseaudioFull.override { jackaudioSupport = true; };
    #};
    opengl = {
      driSupport32Bit = true;
      enable = true;
    };
  };

  services.xserver = {
    synaptics.enable = true;
    #useGlamor = true;
    #deviceSection = ''
    #  Option "DRI" "3"
    #  Option "TearFree" "on"
    #  '';
    #videoDrivers = [ "amdgpu" ];
  };

  fileSystems."/".options =  [ "noatime" "nodiratime" "discard" ];
}
