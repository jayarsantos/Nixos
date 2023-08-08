{ config, pkgs, lib, ... }: {
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

  # Exclude base gnome packages
  environment.gnome.excludePackages = with pkgs.gnome; [
    gnome-remote-desktop
    #epiphany
    geary
    gnome-software
    gnome-tour 
    gnome-console 
    gnome-text-editor
    gnome-connections 
  ];

  environment.systemPackages = with pkgs; [
    #gnomeExtensions.pop-shell
    gnome.gnome-tweaks
    amberol
  ];
}