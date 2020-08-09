# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{

  boot = {

    kernelPackages = pkgs.linuxPackages_latest;

    kernelModules = [ "kvm-amd" "kvm-intel" ];

    kernelParams = [
      "radeon.si_support=0"
      "radeon.cik_support=0"
      "amdgpu.si_support=1"
      "amdgpu.cik_support=1"
      "pci=nommconf"
    ];


    plymouth = {
      enable = true;
    };


    loader = {
      grub = {
        enable = true;
        device = "nodev";
        version = 2;
        enableCryptodisk = true;
        memtest86 = {
          enable = true;
        };
        splashImage = ./media/nixos-splash.png;
      };
    };

    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/a1c7d532-adc5-4b80-83f3-d59bfef75315"; # UUID for /dev/nvme01np2
        preLVM = true;
        allowDiscards = true;
      };
    };

    initrd.network.ssh = {
      enable = true;
      hostEDSAKey = /run/keys/initrd-ssh-key;
    };
  };

  services.compton.enable = true;

  networking = {
    hostName = "drewripper";
    wireless = {
      enable = true;
    };
    interfaces.wlp5s0.ipv4.addresses = [ {
      address = "192.168.1.16";
      prefixLength = 24;
    } ];
    defaultGateway = "192.168.1.1";
    nameservers = [ "8.8.8.8" ];
    dhcpcd.enable = false;
  };

  #sound.extraConfig =
  #  ''
  #    pcm.!default {
  #      type plug
  #      slave.pcm hw
  #    }
  #  '';

  hardware = {
    enableAllFirmware = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
      #package = pkgs.pulseaudioFull.override { jackaudioSupport = true; };
      daemon.config = {
        default-sample-format = "float32le";
        default-sample-rate = "48000";
        alternate-sample-rate = "44100";
        default-sample-channels = "2";
        #default-fragments = "2";
        #default-fragment-size-msec = "125";
        enable-lfe-remixing = "no";
        realtime-scheduling = "yes";
        flat-volumes = "no";
        resample-method = "soxr-hq";
      };
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
    bluetooth.enable = true;
  };

  services.xserver = {
    useGlamor = true;
    deviceSection = ''
      Option "DRI" "3"
      Option "TearFree" "on"
      '';
    videoDrivers = [ "amdgpu" "amdvlk" ];
  };

}
