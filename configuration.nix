# DO NOT FORGET TO RUN ./setup FIRST

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
    ./work/configuration.nix
    ./desktop-manager.nix
  ];

  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
       (import ./work/packages.nix pkgs) ++ (import ./personal/packages.nix pkgs);

  # Notes on fonts: https://functor.tokyo/blog/2018-10-01-japanese-on-nixos
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      anonymousPro
      b612
      corefonts
      dejavu_fonts
      eunomia
      freefont_ttf
      google-fonts
      inconsolata
      liberation_ttf
      powerline-fonts
      source-code-pro
      terminus_font
      ttf_bitstream_vera
      ubuntu_font_family
      carlito
      ipafont
      kochi-substitute
    ];
    #fontconfig.ultimate.enable = true;
    fontconfig.defaultFonts = {
      monospace = [
        "DejaVu Sans Mono"
        "IPAGothic"
      ];
      sansSerif = [
        "DejaVu Sans"
        "IPAGothic"
      ];
      serif = [
        "DejaVu Serif"
        "IPAMincho"
      ];
    };
  };

  i18n = {
    inputMethod = {
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  services = {
    openssh.enable = true;
    udev.packages = [ pkgs.yubikey-personalization
                      pkgs.libu2f-host ];
    pcscd.enable = true;

    printing = {
      enable = true;
    #  browsing = true;
    #  defaultShared = true;
      drivers = with pkgs; [
        brlaser
        brgenml1lpr
        brgenml1cupswrapper
        hll2390dw-cups
      ];
    };

    #avahi = {
    #  enable = true;
    #  publish = {
    #    enable = true;
    #    userServices = true;
    #  };
    #};
  };

  # Enable X window manager and xfce as default desktopManager
  services.xserver = {
    enable = true;
    layout = "us";
    xautolock = {
      enable = true;
      time = 30;
      #extraOptions = [
      #  "-corners 0+00"
      #  "-cornerdelay 1"
      #];
    };
    libinput = {
      enable = true;
      naturalScrolling = true;
      middleEmulation = true;
      disableWhileTyping = true;
      accelSpeed = "0.8";
    };
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
    ssh.startAgent = true;
  };

  # X compositor
  services.compton = {
    # to enable add the follow to local-configuration.nix:
    # services.compton.enable = true;
    fade = true;
    fadeDelta = 5;
    inactiveOpacity = "0.93";
    shadow = true;
    backend = "glx";
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
