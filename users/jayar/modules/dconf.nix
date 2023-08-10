{ lib, ... }:

# This file exclusively contains gnome and gnome extensions dconf configurations
# intended to be imported in ./home.nix
# Also, this wasn't hand-written, it was generated with the pkg
# dconf2nix https://github.com/gvolpe/dconf2nix

with lib.hm.gvariant;
{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      per-window = true;
      sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "latam" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-im-module = "gtk-im-context-simple";
      icon-theme = "candy-icons";
    };

    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>x" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-last = [ "<Super>5" ];
      switch-to-workspace-left = [ "<Super>u" ];
      switch-to-workspace-right = [ "<Super>i" ];
      move-to-workspace-1 = [ "<Shift><Super>exclam" ];
      move-to-workspace-2 = [ "<Shift><Super>at" ];
      move-to-workspace-3 = [ "<Shift><Super>numbersign" ];
      move-to-workspace-4 = [ "<Shift><Super>dollar" ];
      move-to-workspace-last = [ "<Shift><Super>percent" ];
      move-to-workspace-left = [ "<Shift><Super>u" ];
      move-to-workspace-right = [ "<Shift><Super>i" ];
      cycle-windows = [ "<Super>k" ];
      cycle-windows-backward = [ "<Super>j" ];
      toggle-fullscreen = [ "<Super>f" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 5;
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = false;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      www = [ "<Super>w" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "kitty";
      name = "Kitty";
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "code.desktop"
        "ferdium.desktop"
        "Alacritty.desktop"
      ];
      app-picker-layout = "[{'org.gnome.Contacts.desktop': <{'position': <0>}>, 'org.gnome.Weather.desktop': <{'position': <1>}>, 'org.gnome.clocks.desktop': <{'position': <2>}>, 'org.gnome.Maps.desktop': <{'position': <3>}>, 'org.gnome.Totem.desktop': <{'position': <4>}>, 'org.gnome.Calculator.desktop': <{'position': <5>}>, 'simple-scan.desktop': <{'position': <6>}>, 'org.gnome.Settings.desktop': <{'position': <7>}>, 'org.gnome.Extensions.desktop': <{'position': <8>}>, 'gnome-system-monitor.desktop': <{'position': <9>}>, 'Alacritty.desktop': <{'position': <10>}>, 'nixos-manual.desktop': <{'position': <11>}>, 'Utilities': <{'position': <12>}>, 'btop.desktop': <{'position': <13>}>, 'yelp.desktop': <{'position': <14>}>, 'xterm.desktop': <{'position': <15>}>, 'org.gnome.Epiphany.desktop': <{'position': <16>}>, 'org.gnome.Cheese.desktop': <{'position': <17>}>, 'org.gnome.Calendar.desktop': <{'position': <18>}>, 'htop.desktop': <{'position': <19>}>}, {'org.gnome.Music.desktop': <{'position': <0>}>, 'nvim.desktop': <{'position': <1>}>, 'Helix.desktop': <{'position': <2>}>, 'obsidian.desktop': <{'position': <3>}>, 'android-studio.desktop': <{'position': <4>}>, 'org.gnome.Boxes.desktop': <{'position': <5>}>, 'virt-manager.desktop': <{'position': <6>}>, 'org.gnome.Photos.desktop': <{'position': <7>}>, 'ferdium.desktop': <{'position': <8>}>, 'mpv.desktop': <{'position': <9>}>, 'umpv.desktop': <{'position': <10>}>, 'org.godotengine.Godot.desktop': <{'position': <11>}>, 'ranger.desktop': <{'position': <12>}>, 'code.desktop': <{'position': <13>}>}]";
      disabled-extensions = [];
      enabled-extensions = [
        "caffeine@patapon.info"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "unite@hardpixel.eu"
        "widgets@aylur"
      ];
    };

    "org/gnome/shell/extensions/aylurs-widgets" = {
      background-clock = false;
      battery-bar = false;
      dash-board = false;
      dash-link-names = [ "reddit" "youtube" "gmail" "twitter" "github" ];
      dash-link-urls = [ "https://www.reddit.com/" "https://www.youtube.com/" "https://www.gmail.com/" "https://twitter.com/" "https://www.github.com/" ];
      date-menu-mod = false;
      media-player = false;
      notification-indicator = false;
      power-menu = false;
      quick-toggles = false;
      workspace-indicator-offset = 1;
    };

    "org/gnome/shell/extensions/caffeine" = {
      enable-fullscreen = false;
      indicator-position-max = 1;
      inhibit-apps = [ "mpv.desktop" ];
      trigger-apps-mode = "on-active-workspace";
    };

    "org/gnome/shell/extensions/unite" = {
      app-menu-ellipsize-mode = "middle";
      app-menu-max-width = 1;
      autofocus-windows = true;
      extend-left-box = false;
      hide-activities-button = "never";
      hide-app-menu-icon = false;
      hide-window-titlebars = "maximized";
      notifications-position = "center";
      reduce-panel-spacing = true;
      restrict-to-primary-screen = true;
      show-desktop-name = false;
      show-window-buttons = "always";
      show-window-title = "never";
      window-buttons-placement = "left";
      window-buttons-theme = "arc";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Flat-Remix-Violet-Dark-fullPanel";
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
    };
  };
}
