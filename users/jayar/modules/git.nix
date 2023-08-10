{pkgs, ...}:
{
 home.packages = with pkgs;[
  git-crypt
  pinentry-gnome
 ];
  programs.git = {
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
}

