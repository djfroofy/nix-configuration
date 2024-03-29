# This is local configuration for my ThinkPad T490

{ config, pkgs, ...}:
{

  imports = [
    <nixos-hardware/lenovo/thinkpad/t480s/default.nix>
  ];

  boot = {
    kernelParams = [ "intel_pstate=no_hwp" ];
    kernelPackages = pkgs.linuxPackages_latest;

    kernelModules = [
       #"snd-seq"
       #"snd-rawmidi"
       "kvm-intel"
    ];

    loader = {
      grub = {
          enable = true;
          device = "nodev";
          #version = 2;
          enableCryptodisk = true;
          efiSupport = true;
          gfxmodeEfi = "1024x780";
          splashImage = ./media/nixos-splash.png;
      };
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices = {
        root = {
          device = "/dev/disk/by-uuid/5a077266-c0f4-4e55-afe6-e225c5eaab6e";
          preLVM = true;
          allowDiscards = true;
        };
    };
    plymouth = {
      enable = true;
    };
  };

  networking = {
    hostName = "drewthinkpad";
    wireless = {
      enable = false;
    };
    networkmanager.enable = true;
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
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      #extraModules = [ pkgs.pulseaudio-modules-bt ];
    #  package = pkgs.pulseaudioFull.override { jackaudioSupport = true; };
      daemon = {
        config = {
          default-sample-format = "s24le";
          default-sample-rate = 192000;
        };
      };
    };
    opengl = {
      driSupport32Bit = true;
      enable = true;
    };
    bluetooth.enable = true;
  };

  powerManagement.cpuFreqGovernor = "performance";


  services.picom.enable = false;


  # systemd.packages = [ pkgs.tlp ];
  #services.tlp = {
  #  enable = false;
  #  extraConfig = ''
  #  CPU_MIN_PERF_ON_AC=0
  #  CPU_MAX_PERF_ON_AC=100
  #  CPU_MIN_PERF_ON_BAT=0
  #  CPU_MAX_PERF_ON_BAT=30
  #  '';
  #};

  services.xserver = {
    synaptics = {
      enable = false;
      twoFingerScroll = true;
      horizTwoFingerScroll = true;
      vertTwoFingerScroll = true;
      accelFactor = "0.05";
      minSpeed = "0.35";
      maxSpeed = "4.0";
    };
    #useGlamor = true;
    #deviceSection = ''
    #  Option "DRI" "3"
    #  Option "TearFree" "on"
    #  '';
    #videoDrivers = [ "amdgpu" ];
    #videoDrivers = [ "nvidiaBeta" ];
  };

  fileSystems."/".options =  [ "noatime" "nodiratime" "discard" ];
}
