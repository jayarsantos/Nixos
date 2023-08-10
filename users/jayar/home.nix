{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  imports = [
    ./modules/dconf.nix
    ./modules/nixvim
    ./modules/fish.nix
    ./modules/starship.nix # fish now has it's own prompt goodies
    ./modules/git.nix
    ./modules/spotifyd.nix
    # ./custom-fonts
    ];
  nixpkgs = {
    # You can add overlays here
    overlays = [
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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

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
      passff-host
      chromium
      inkscape
      obs-studio
      discord
      ferdium
      lutris
      obsidian
      postman
      youtube-music
      cemu
      anydesk # unfree
      mpv
      remmina

      # wine
      wineWowPackages.stable

      # dev gui apps
      vscode.fhs
      android-studio
      godot_4

      # virtualization
      gnome.gnome-boxes
      virt-manager

      # cli apps
      ani-cli
      mov-cli

      # dev dependencies
      # -- python
      python311
      poetry
      python311Packages.pip
      python311Packages.ipykernel

      # -- node js
      nodejs
      nodePackages.pnpm
      nodePackages.eas-cli

      # -- rust
      rustup

      # nvchad
      gcc
      ripgrep

      # gnome extensions
      gnomeExtensions.unite
      gnomeExtensions.caffeine
      gnomeExtensions.aylurs-widgets
      gnomeExtensions.blur-my-shell
      gnomeExtensions.burn-my-windows

      # gnome themes
      catppuccin-gtk
      flat-remix-gnome

      #utilities
      unzip
      p7zip

      # fonts
      (nerdfonts.override { fonts = [
        "JetBrainsMono"
        "Iosevka"
        "DejaVuSansMono"
        "FantasqueSansMono"
      ];
      })

      # spotify
      spotify
      spotify-tui
      whatsapp-for-linux
      nchat
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
        PASSWORD_STORE_DIR = "$HOME/.password-store";
        PASSWORD_STORE_CLIP_TIME = "15";
        PASSWORD_STORE_KEY = "BEEEC35C99A234339040344C1024516BEE4EEB1F";
      };
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

  #declared in nixvim setup
  # home.sessionVariables = {
  #   EDITOR = "vim";
  # };

  xdg.configFile = {
   "kitty".source = ./configs/kitty;
   "joshuto".source = ./configs/joshuto;
   "mpd".source = ./configs/mpd;
   # "spotify-tui".source = ./configs/spotify-tui;
   # "spotifyd".source = ./configs/spotifyd;
   "mutt".source = ./configs/mutt;
   "msmtp".source = ./configs/msmtp;
   "foot".source = ./configs/foot;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
