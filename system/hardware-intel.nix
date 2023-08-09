{ config, pkgs, lib, ... }:

{
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  # nixpkgs.config.packageOverrides = pkgs: {
  #   vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  # };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      (if (lib.versionOlder (lib.versions.majorMinor lib.version) "23.11")
        then vaapiIntel
        else intel-vaapi-driver
      )
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      libvdpau-va-gl
    ];
  };

  boot.initrd.kernelModules = [ "i915" ];

  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };

}
