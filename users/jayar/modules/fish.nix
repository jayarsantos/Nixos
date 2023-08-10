{pkgs, ...}:
{
 home.packages = with pkgs;[
  fishPlugins.autopair
  grc
  jq
  exa
  fd
  fzf
  ripgrep
 ];

 programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      starship init fish | source
    '';
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
    shellAbbrs = {
      v = "nvim";
      c = "clear";
      j = "joshuto";
      gcollect = "sudo nix-collect-garbage -d | nix-collect-garbage -d";
      apply-sys = "sh ~/.dotfiles/scripts/apply-system.sh";
      apply-user = "sh ~/.dotfiles/scripts/apply-users.sh";
      update-flock = "sh ~/.dotfiles/scripts/update-flake.sh";
      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gap = "git add --patch";
      gapp = "git apply";
      gb = "git branch --verbose";
      gbr = "git branch --verbose --remotes";
      gbd = "git branch --delete";
      gbD = "git branch --delete --force";
      gc = "git commit -m";
      gca = "git commit --amend";
      gcl = "git clone";
      gco = "git checkout";
      gcot = "git checkout --theirs";
      gcp = "git cherry-pick --strategy-option theirs";
      gcpx = "git cherry-pick --strategy-option theirs -x";
      gd = "git diff";
      gds = "git diff --staged";
      gf = "git fetch";
      gi = "git init";
      gl = "git log --oneline --decorate --graph -n 10";
      gm = "git merge";
      gp = "git push";
      gpu = "git pull";
      gr = "git reset HEAD~";
      gR = "git restore";
      gRs = "git restore --staged";
      gra = "git remote add";
      gre = "git remote --verbose";
      grh = "git reset HEAD";
      grr = "git reset --hard HEAD~";
      grb = "git rebase --interactive";
      grbc = "git rebase --continue";
      gs = "git status";
      gst = "git stash";
      gstp = "git stash pop";
      gsw = "git switch";
      gt = "git tag";
      gts = "git tag -s";
    };
 };
}
