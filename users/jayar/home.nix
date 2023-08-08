{ config, pkgs, unstable, ... }:

#let
#  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
#in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  imports = [ ./configs/dconf.nix ];
  #nixpkgs.config = config.nixpkgs.config;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home = {
    username = "jayar";
    homeDirectory = "/home/jayar";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.05";
    packages = with pkgs; [
      # gui apps
      #firefox
      passff-host
      chromium
      inkscape
      #unstable.obs-studio
      #unstable.discord
      #unstable.ferdium
      #unstable.lutris
      #unstable.obsidian
      #unstable.postman
      #unstable.youtube-music
      #unstable.cemu
      #anydesk # unfree
      mpv
      remmina

      # wine
      wineWowPackages.stable

      # dev gui apps
      #unstable.vscode.fhs
      #unstable.android-studio
      #unstable.godot_4

      # virtualization
      gnome.gnome-boxes
      virt-manager

      # cli apps
      neovim # I only use it inside vscode. Helix ftw
      #unstable.ani-cli
      #unstable.dconf2nix
      #unstable.mov-cli

      # dev dependencies
      # -- python
      #unstable.python311
      #unstable.poetry 
      #unstable.python311Packages.pip
      #unstable.python311Packages.ipykernel

      # -- node js
      #unstable.nodejs
      #unstable.nodePackages.pnpm
      #unstable.nodePackages.eas-cli

      # -- rust
      rustup

      # nvchad
      gcc
      ripgrep      

      # gnome extensions
      #unstable.gnomeExtensions.unite
      #unstable.gnomeExtensions.caffeine
      gnomeExtensions.aylurs-widgets
      #unstable.gnomeExtensions.blur-my-shell
      #unstable.gnomeExtensions.burn-my-windows

      # gnome themes
      gnome.gnome-tweaks
      #unstable.catppuccin-gtk
      flat-remix-gnome

      # fonts
      (nerdfonts.override { fonts = [ 
        "JetBrainsMono" 
        "Iosevka" 
        "DejaVuSansMono"
        "FantasqueSansMono"
        ]; 
      })

      #git
      git-crypt
      pinentry-gnome
    ]; 
  };

  # fonts.fontconfig.enable = true;

  programs = {  
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    firefox = {
      enable = true;
      package = (pkgs.firefox.override { extraNativeMessagingHosts = [ pkgs.passff-host ]; });
    };
    kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
    };
    password-store = {
      enable = true;
      package = pkgs.pass-wayland.withExtensions (exts: [ exts.pass-otp ]);
      settings = {
        PASSWORD_STORE_CLIP_TIME = "15";
        PASSWORD_STORE_KEY = "BEEEC35C99A234339040344C1024516BEE4EEB1F";
      };
    };
    git = {
      enable = true;
      userName  = "Alejandro P. Santos III";
      userEmail = "jayarsantos@mail.com"; 
      signing = {
        signByDefault = true;
        key = "C0439FF5660EFCEB";
      };
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = false;
      };
      ignores = [
        # IntelliJ files and folders
        # ".git/"
        "result"
      ];
      attributes = [
        ".secrets/** filter=git-crypt diff=git-crypt"
      ];
    };
    gpg = {
      enable = true;
    };
  };
  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jayar/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.configFile = {
   "kitty".source = ./configs/kitty;
   "joshuto".source = ./configs/joshuto;
   "mpd".source = ./configs/mpd;
   "spotify-tui".source = ./configs/spotify-tui;
   "spotifyd".source = ./configs/spotifyd;
   "mutt".source = ./configs/mutt;
   "msmtp".source = ./configs/msmtp;
   "foot".source = ./configs/foot;
  };
}
