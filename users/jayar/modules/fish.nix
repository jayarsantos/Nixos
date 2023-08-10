{pkgs, ...}:
{
 home.packages = with pkgs;[
  fishPlugins.autopair
  grc
 ];
 programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAbbrs = {
      c = "clear";
      gc = "sudo nix-collect-garbage -d | nix-collect-garbage -d";
      apply-sys = "sh ~/.dotfiles/scripts/apply-system.sh";
      apply-user = "sh ~/.dotfiles/scripts/apply-users.sh";
      update-flock = "sh ~/.dotfiles/scripts/update-flake.sh";
    };
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      # Manually packaging and enable a plugin
      {
      name = "z";
      src = pkgs.fetchFromGitHub {
        owner = "jethrokuan";
        repo = "z";
        rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
        sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
      };
    }
  ];
 };
}
