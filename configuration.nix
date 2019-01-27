# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{

  nixpkgs.config = {
    allowUnfree = true;
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


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
  };

  boot.loader = {
    grub = {
    	enable = true;
    	device = "nodev";
    	version = 2;
    	enableCryptodisk = true;
    };
  };
  
  boot.initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/disk/by-uuid/a1c7d532-adc5-4b80-83f3-d59bfef75315"; # UUID for /dev/nvme01np2 
        preLVM = true;
        allowDiscards = true;
      }
  ];


  networking.hostName = "drewripper";
  networking.wireless.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     xorg.xmodmap
     xlibs.xmodmap
     wget
     git
     vim
     tmux
     firefox
     blender
     sysbench
     rustc
     cargo
     zsh
     python
     ruby
     docker
     zip
     unzip
     pciutils
     pamixer
     paprefs
     minetest
     htop
     glxinfo
     gimp
     termite
     dmenu
     oh-my-zsh
     lolcat
     jq
     vscode
     tree
     qemu
     chuck
     gtypist
     ffmpeg
     mplayer
     audacity
     racer
     jack2
     sysbench
     haskellPackages.xmobar
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      anonymousPro
      corefonts
      dejavu_fonts
      freefont_ttf
      google-fonts
      inconsolata
      liberation_ttf
      powerline-fonts
      source-code-pro
      terminus_font
      ttf_bitstream_vera
      ubuntu_font_family  
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # nable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;

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


  programs = {
    vim = {
      defaultEditor = true;
    };

    zsh.ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "rust" "cargo" ];
      theme = "agnoster";
    };

    #zsh = {
    #  interactiveShellInit = ''
    #  export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
    #
    #  ZSH_THEME="agnoster"
    #  plugins=(git, python, rust, cargo)
    #  source $ZSH/oh-my-zsh.sh
    #  '';
    #  promptInit = "";
    #};
  };
  # Enable X window manager and xfce as default desktopManager
  #
  services.xserver = {
    enable = true;
    layout = "us";
    useGlamor = true;
    deviceSection = ''
      Option "DRI" "3"
      Option "TearFree" "on"
      '';
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
          haskellPackages.xmobar
        ];
      };
      default = "xmonad";
    };
    videoDrivers = [ "amdgpu" ];
  };
  #};
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  environment.variables = {
    TERMINAL =  [ "termite" ];
    OH_MY_ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
    ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dsmather = {
    shell = pkgs.zsh;
    isNormalUser = true;
    home = "/home/dsmather";
    description = "Drew Smathers";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDG1w8RG7zAv0zxBBfwq4xJu1JH7yCYvG8SAZTfoBLmRUvAUWtlvulxaG7xW9B+gsrCKG+4c2GgN2Q1+nT08qHlceD/2zCG5tTiZ/h0BYv3nQg7D2aJ+hRBHZI1taRgImo7V/iZNIS7KOxSL+QZOl23Id4T1I64I/32qkJT6viG6GSagQ3EZVb9yzZQoATV/WZjB7VylFp7hpwlvwBeSLYotgvhgEWPizj1a06v0+WsczvENx2evZFRjrNEejCED4N5F6G1RPMced1Wxo5SOKKhZA60aw6gGl+p6fTvDQTkwefjVdnS9YMghNSpvRfJQfha/LinQEWIHlpg2lW8HBKr dsmather@dsmather-mac" ];

  };
  users.users.nzs = {
    shell = pkgs.zsh;
    isNormalUser = true;
    home = "/home/nzs";
    extraGroups = [ "wheel" "networkmanager" ];
  };


  security.sudo.wheelNeedsPassword = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
