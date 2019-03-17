# DO NOT FORGET TO RUN ./setup.sh FIRST

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:
{

  nixpkgs.config = {
    allowUnfree = true;
  };

  imports = [
    ./hardware-configuration.nix
    ./local-configuration.nix
  ];

  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # X, Window Management
    haskellPackages.xmobar
    xorg.xmodmap
    xlibs.xmodmap
    dmenu

    # Web Browsing
    firefox
    lynx

    # Editors
    vim

    # Shell
    zsh
    termite
    oh-my-zsh

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
    sysbench
    wget
    git
    file
    lsof
    binutils

    # Performance Testing
    sysbench

    # ---
    # Development
    # ----

    # General
    gnumake

    # C
    gcc

    # Python and python packages
    python
    python27Packages.virtualenv
    python27Packages.pykickstart

    # Ruby
    ruby

    # Haskell
    ghc

    # Code editors, IDEs 
    vscode

    # OS and user-space emulation
    docker
    qemu

    # Rust
    rustc
    rust-src
    cargo
    racer
    racer

    # ---
    # AV and Games
    # ---


    # Audio
    pamixer
    paprefs
    maim
    alsaLib
    fluidsynth
    soundfont-fluid
    jack2
    jack_rack
    timemachine
    audacity
    chuck
    qjackctl

    # Photo Editing
    gimp
    blender

    # Video
    ffmpeg
    (pkgs.mplayer.override { jackaudioSupport = true; })
    (pkgs.mpv.override { jackaudioSupport = true; })
    (pkgs.blender.override { jackaudioSupport = true; })

    # Games, GFX Demos etc
    minetest
    glxinfo
    gtypist
    
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

  # enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  };

  # Remote desktop support
  services.xrdp = {
    enable = true;
    defaultWindowManager = "${pkgs.haskellPackages.xmonad}/bin/xmonad";
  };
  networking.firewall.allowedTCPPorts = [ 3389 ];

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

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
    extraGroups = [ "audio" "wheel" "networkmanager" "docker"];
    hashedPassword = "$6$6dxm0ny2cHwxhlQ$kzcaiMHaDzhT1lld91jCEaMHSLeU6QCNBjxZUixRj2QbVpH7Uhzg24ak53Qu4Ua1gH7UUGrfSJv7Tt66RlcWA1";
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


  security.sudo.wheelNeedsPassword = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
