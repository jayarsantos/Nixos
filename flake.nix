{
  description = "Home Manager configuration of jayar";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      #pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        jaynix = lib.nixosSystem {
          inherit system;
           modules = [
            ./system/configuration.nix
           ];
        };
      };
      # homeConfigurations."jayar" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #
      #   # Specify your home configuration modules here, for example,
      #   # the path to your home.nix.
      #   modules = [ ./users/jayar/home.nix ];
      #
      #   # Optionally use extraSpecialArgs
      #   # to pass through arguments to home.nix
      # };
    };
}
