# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hardware-accellaration.nix
      # <home-manager/nixos>
    ];

  # Bootloader.
  boot = {
    tmp.cleanOnBoot = true;
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true; # nice boot splash screen
    plymouth.theme = "bgrt"; # default is bgrt
  
  };

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-e2d9a311-caa6-4e60-bacf-3f736d23682c".device = "/dev/disk/by-uuid/e2d9a311-caa6-4e60-bacf-3f736d23682c";
  boot.initrd.luks.devices."luks-e2d9a311-caa6-4e60-bacf-3f736d23682c".keyFile = "/crypto_keyfile.bin";

  networking = {
    hostName = "jaynix"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  };

  nix = {
   # settings = {
   #  auto-optimizse-store = true;
   #};
    package = pkgs.nixFlakes;
    extraOptions = ''
     experimental-features = nix-command flakes
   '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_PH.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fil_PH";
    LC_IDENTIFICATION = "fil_PH";
    LC_MEASUREMENT = "fil_PH";
    LC_MONETARY = "fil_PH";
    LC_NAME = "fil_PH";
    LC_NUMERIC = "fil_PH";
    LC_PAPER = "fil_PH";
    LC_TELEPHONE = "fil_PH";
    LC_TIME = "fil_PH";
  };

  services = {
    xserver = {
      enable = true; # Enable the X11 windowing system.
      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      excludePackages = [ pkgs.xterm ];
      # Configure keymap in X11
      layout = "us";
      xkbVariant = "";
    };
   input-remapper.enable = true;
   };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        set number
        set cc=80
        set clipboard+=unnamedplus
        " set list
        " set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
        if &diff
          colorscheme blue
        endif
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ vim-nix ];
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jayar = {
    isNormalUser = true;
    description = "Alejandro P. Santos III";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ 
      "JetBrainsMono" 
      "Iosevka"
      "DejaVuSansMono"
     ]; 
    })
  ];

  # home-manager.users.jayar = import ./home.nix { inherit pkgs unstable config lib; };

  programs = {
    dconf.enable = true;
    fish = {
      enable = true;
      promptInit = ''
        any-nix-shell fish --info-right | source
        source (/run/current-system/sw/bin/starship init fish --print-full-init | psub)
      '';
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  environment = {
    shells = with pkgs; [ fish ];
    gnome.excludePackages = (with pkgs; [ 
      gnome-tour 
      gnome-console 
      gnome-text-editor
      gnome-connections 
    ]) ++ (
      with pkgs.gnome; [ geary ]
    );
    systemPackages = with pkgs; [
      # gui apps that can't be installed on home.nix
      input-remapper
      # command line apps
      killall
      any-nix-shell
      lsd
      btop
      htop
      nvd
      git
      joshuto
      fzf
      bat
      lazygit
      wl-clipboard
      wget
      curl
      # fish
      unstable.starship
      fishPlugins.fzf-fish
    ];
  };

  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.copySystemConfiguration = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
