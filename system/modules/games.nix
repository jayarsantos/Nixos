{ pkgs, ... }: {
  #hax for steam to launch
  hardware.opengl = {
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva
      pipewire
    ];
    setLdLibraryPath = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      rocm-runtime
    ];
  };

  # programs.steam.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    steam-run
    desmume
  ];
}
