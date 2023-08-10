# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [
      # ./modules/flatpak.nix
      ./modules/games.nix
      ./modules/gnome.nix
      ./hardware-configuration.nix
      ./hardware-intel.nix
    ];

  # Bootloader.
  boot = {
    tmp.cleanOnBoot = true;
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true; # nice boot splash screen
    plymouth.theme = "bgrt"; # default is bgrt

    # Setup keyfile
    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };

    # Enable swap on luks
    initrd.luks.devices."luks-e2d9a311-caa6-4e60-bacf-3f736d23682c".device = "/dev/disk/by-uuid/e2d9a311-caa6-4e60-bacf-3f736d23682c";
    initrd.luks.devices."luks-e2d9a311-caa6-4e60-bacf-3f736d23682c".keyFile = "/crypto_keyfile.bin";

  };

  # Services
  services = {
    tlp.enable = lib.mkDefault (
      (lib.versionOlder (
        lib.versions.majorMinor lib.version
        ) "23.05") || !config.services.power-profiles-daemon.enable
    );
    # for ssd's
    fstrim.enable = lib.mkDefault true;
    # Enable CUPS to print documents.
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      # media-session.enable = true;

      # Enable touchpad support (enabled default in most desktopManager).
      # services.xserver.libinput.enable = true;

    };
  };

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = false; # should be set to false when pipewire is in use

  security.rtkit.enable = true;

  networking = {
    hostName = "jaynix"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
    };
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      allowed-users = ["@wheel"];
      trusted-users = ["root" "jayar"];
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

  programs = {
    dconf.enable = true;
  };

  environment = {
    shells = with pkgs; [ fish ];
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
      fishPlugins.fzf-fish
      vim
      libreoffice
    ];
  };

  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
