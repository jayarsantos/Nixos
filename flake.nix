{
  description = "My Gnome in a flake configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # unstable
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

  };

  outputs = { nixpkgs, home-manager, nixvim, unstable, home-unstable, ... }@inputs:
   {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      jaynix = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [ ./system/configuration.nix ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "jayar@jaynix" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
         inherit inputs;
         }; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [
        ./users/jayar/home.nix
        ];
      };
    };
   };
}
