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
    # machine configuration (todo: should be renamed machine.nix
    ./local-configuration.nix
    ./users.nix
    ./work/configuration.nix
    ./desktop-manager.nix
    ./printing.nix
  ];

  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
       (import ./work/packages.nix pkgs) ++ (import ./personal/packages.nix pkgs);

  # Notes on fonts: https://functor.tokyo/blog/2018-10-01-japanese-on-nixos
  fonts = {
    fontDir.enable = true;
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
      # enabled = "fcitx5";
      enabled = "ibus";
      # fcitx.engines = with pkgs.fcitx-engines; [ mozc libpinyin anthy ];
      # fcitx5.addons = with pkgs; [ fcitx5-anthy fcitx5-mozc ];
      ibus.engines = with pkgs.ibus-engines; [ mozc libpinyin anthy ];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  services = {
    localtimed.enable = false;
    openssh = {
      enable = true;
      banner = ''
        __/\\\________/\\\_______/\\\\\_______/\\\\\\\\\\\_
         _\///\\\____/\\\/______/\\\///\\\____\/////\\\///__
          ___\///\\\/\\\/______/\\\/__\///\\\______\/\\\_____
           _____\///\\\/_______/\\\______\//\\\_____\/\\\_____
            _______\/\\\_______\/\\\_______\/\\\_____\/\\\_____
             _______\/\\\_______\//\\\______/\\\______\/\\\_____
              _______\/\\\________\///\\\__/\\\________\/\\\_____
               _______\/\\\__________\///\\\\\/______/\\\\\\\\\\\_
                _______\///_____________\/////_______\///////////__
      '';
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        X11Forwarding = true;
      };
    };
    udev.packages = with pkgs; [
      yubikey-personalization
      libu2f-host
    ];
    pcscd.enable = true;

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
      touchpad = {
        naturalScrolling = true;
        middleEmulation = true;
        disableWhileTyping = true;
        accelSpeed = "0.8";
      };
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
    zsh = {
      enable = false;
      ohMyZsh = {
        enable = false;
      };
    };
    fish.enable = true;
    ssh.startAgent = true;
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "qt";
    };
  };

  # pairing bluetooth devices
  #services.blueman.enable = true;

  # X compositor
  services.picom = {
    # to enable add the follow to local-configuration.nix:
    # services.compton.enable = true;
    fade = true;
    fadeDelta = 5;
    inactiveOpacity = 0.93;
    shadow = true;
    backend = "glx";
  };


  environment.variables = {
    TERMINAL =  [ "kitty" ];
    OH_MY_ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
    ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];

  };

  services.trezord.enable = true;

  # udev ruls for trezor - this should be refactored
#   services.udev.extraRules = ''
# # Trezor
# "SUBSYSTEM=="usb", ATTR{idVendor}=="534c", ATTR{idProduct}=="0001", MODE="0660", GROUP="plugdev", TAG+="uaccess", TAG+="udev-acl", SYMLINK+="trezor%n"
# KERNEL=="hidraw*", ATTRS{idVendor}=="534c", ATTRS{idProduct}=="0001", MODE="0660", GROUP="plugdev", TAG+="uaccess", TAG+="udev-acl"
#
# # Trezor v2
# SUBSYSTEM=="usb", ATTR{idVendor}=="1209", ATTR{idProduct}=="53c0", MODE="0660", GROUP="plugdev", TAG+="uaccess", TAG+="udev-acl", SYMLINK+="trezor%n"
# SUBSYSTEM=="usb", ATTR{idVendor}=="1209", ATTR{idProduct}=="53c1", MODE="0660", GROUP="plugdev", TAG+="uaccess", TAG+="udev-acl", SYMLINK+="trezor%n"
# KERNEL=="hidraw*", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="53c1", MODE="0660", GROUP="plugdev", TAG+="uaccess", TAG+="udev-acl"
 # '';


  security.sudo.wheelNeedsPassword = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "23.05"; # Did you read the comment?
}
