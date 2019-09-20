# DO NOT FORGET TO RUN ./setup.sh FIRST

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:
{

  nixpkgs.config = {
    allowUnfree = true;
    oraclejdk.accept_license = true;
  };

  imports = [
    #<musnix>
    ./hardware-configuration.nix
    ./local-configuration.nix
    ./users.nix
  ];

  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # X, Window Management
    xorg.xmodmap
    xlibs.xmodmap

    # Web Browsing
    lynx

    # Editors
    vim

    # Shell
    zsh
    termite
    oh-my-zsh
    dropbear

    # OS and user-space emulation
    docker
    qemu

    # Common *nix utils
    socat
    tmux
    zip
    unzip
    mkpasswd
    dnsmasq
    htop
    pciutils
    tgt
    lolcat
    jq
    tree
    wget
    git
    file
    lsof
    binutils
    lshw
    iproute
    ncdu

    # Performance Testing
    sysbench
    flameGraph
    linuxPackages.perf
    
    # HW Diagnostics
    memtest86plus

    
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

  services = {
    openssh.enable = true;
    #printing = {
    #  enable = true;
    #  browsing = true;
    #  defaultShared = true;
    #  drivers = with pkgs; [
    #    brlaser
    #    brgenml1lpr
    #    brgenml1cupswrapper
    #  ];
    #};
    #avahi = {
    #  enable = true;
    #  publish = {
    #    enable = true;
    #    userServices = true;
    #  };
    #};
  };

  # enable docker
  virtualisation.docker.enable = true;

  # Enable sound.
  sound.enable = true;


  programs = {
  
    vim = {
      defaultEditor = true;
    };
  
    zsh.ohMyZsh = {
      enable = true;
    };

  };



  # Enable X window manager and xfce as default desktopManager
  services.xserver = {
    enable = true;
    layout = "us";
    xautolock = {
      enable = true;
      time = 5;
      extraOptions = [
        "-corners 0+00"
        "-cornerdelay 1"
      ];
    };
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
      default = "xmonad";
    };
  };


  environment.variables = {
    TERMINAL =  [ "termite" ];
    OH_MY_ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
    ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];

  };


  security.sudo.wheelNeedsPassword = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}
